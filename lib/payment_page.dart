import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'success_page.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, int> cart;
  final String role;
  final String loginId;
  final String facultyId;
  final String location;

  const PaymentPage({
    super.key,
    required this.cart,
    required this.role,
    required this.loginId,
    required this.facultyId,
    required this.location,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPayment = "UPI / Scanner";
  String _selectedLocation = "Main Canteen";
  final TextEditingController _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.location;
  }

  double _calculateTotal() {
    double total = 0;
    widget.cart.forEach((key, value) => total += (value * 10)); 
    return total;
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = ["Main Canteen"];
    if (widget.role == "Faculty") options.add("Staff Room");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Delivery Location", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedLocation,
              items: options.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
              onChanged: (v) => setState(() => _selectedLocation = v!),
            ),

            if (widget.role == "Faculty" && _selectedLocation == "Staff Room") ...[
              const SizedBox(height: 20),
              TextField(
                controller: _detailsController,
                decoration: const InputDecoration(
                  labelText: "Floor, Dept & Cabin Number",
                  prefixIcon: Icon(Icons.location_city, color: Color(0xFFE23744)),
                ),
              ),
            ],

            const SizedBox(height: 35),
            const Text("Payment Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 15),

            _buildOption("UPI / Scanner", Icons.qr_code_scanner),
            _buildOption("Cash at Counter", Icons.payments_outlined),
            if (widget.role == "Faculty")
              _buildOption("Pay Later (Monthly Bill)", Icons.history_toggle_off),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  // 1. SHOW PROCESSING DIALOG (The "Loading" part)
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(color: Color(0xFFE23744)),
                    ),
                  );

                  // 2. UPI REDIRECTION
                  if (_selectedPayment == "UPI / Scanner") {
                    final String upiUrl = 'upi://pay?pa=canteen@upi&pn=Canteen&am=${_calculateTotal()}&cu=INR';
                    final Uri uri = Uri.parse(upiUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  }

                  // 3. SIMULATE PROCESSING DELAY
                  await Future.delayed(const Duration(seconds: 2));

                  if (!mounted) return;

                  // 4. CLOSE DIALOG & MOVE TO SUCCESS
                  Navigator.pop(context); // Remove loading spinner
                  
                  String finalLoc = _selectedLocation;
                  if (widget.role == "Faculty" && _selectedLocation == "Staff Room") {
                    finalLoc = "$_selectedLocation (${_detailsController.text})";
                  }

                  Navigator.push(context, MaterialPageRoute(
                    builder: (c) => SuccessPage(
                      cart: widget.cart,
                      role: widget.role,
                      paymentMethod: _selectedPayment,
                      location: finalLoc,
                      facultyId: widget.facultyId,
                    )
                  ));
                },
                child: const Text("CONFIRM ORDER", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String title, IconData icon) {
    bool isSelected = _selectedPayment == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? const Color(0xFFE23744) : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(15),
          color: isSelected ? const Color(0xFFFFF5F5) : Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFFE23744) : Colors.grey),
            const SizedBox(width: 15),
            Text(title, style: TextStyle(color: isSelected ? const Color(0xFFE23744) : Colors.black, fontWeight: FontWeight.bold)),
            const Spacer(),
            if (isSelected) const Icon(Icons.check_circle, color: Color(0xFFE23744)),
          ],
        ),
      ),
    );
  }
}