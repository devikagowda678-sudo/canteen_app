import 'package:flutter/material.dart';
import 'main.dart';
// Updated to match your actual filename 'item_list.dart'
import 'item_list.dart'; 

class SuccessPage extends StatelessWidget {
  final Map<String, int> cart;
  final String role;
  final String paymentMethod;
  final String location;
  final String? facultyId;

  const SuccessPage({
    super.key,
    required this.cart,
    required this.role,
    required this.paymentMethod,
    required this.location,
    this.facultyId,
  });

  // --- EXACT DATA PRESERVED ---
  static const Map<String, int> itemPrices = {
    "Full Veg Meals": 70,
    "Mini North Indian Meals": 60,
    "Veg Fried Rice": 50,
    "Paneer Biryani": 80,
    "Jeera Rice & Dal": 55,
    "Bisi Bele Bath": 40,
    "Set Dosa": 30,
    "Masala Dosa": 45,
    "Idli Vada (2+1)": 35,
    "Poori Sabji": 40,
    "Parota (2 pcs)": 50,
    "Rice Bath": 30,
    "Veg Puff": 15,
    "Samosa": 12,
    "Bread Omlette": 35,
    "Mangalore Bajji": 25,
    "Tea": 10,
    "Coffee": 12,
    "Badam Milk": 15,
    "Fruit Salad": 30,
  };

  // --- EXACT FUNCTION PRESERVED ---
  double _calculateGrandTotal() {
    double total = 0;
    cart.forEach((name, qty) {
      int price = itemPrices[name] ?? 0;
      total += (price * qty);
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double grandTotal = _calculateGrandTotal();

    // --- EXACT FEATURE PRESERVED: Global Orders for Admin ---
    WidgetsBinding.instance.addPostFrameCallback((_) {
      globalOrders.add({
        "id": DateTime.now().millisecondsSinceEpoch.toString().substring(9),
        "role": role,
        "facultyId": facultyId ?? "Student",
        "items": Map<String, int>.from(cart),
        "total": grandTotal,
        "timestamp": DateTime.now(),
        "payment": paymentMethod,
        "location": location,
        "status": "Pending",
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F9F1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, color: Color(0xFF24963F), size: 80),
              ),
              const SizedBox(height: 15),
              const Text("ORDER PLACED", 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1C1C1C))),
              const SizedBox(height: 30),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 4))
                  ],
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                      ),
                      child: const Text("RECEIPT SUMMARY", textAlign: TextAlign.center, 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey, letterSpacing: 1.2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          _row("Payment:", paymentMethod),
                          _row("Location:", location),
                          if (facultyId != null && facultyId!.isNotEmpty)
                            _row("ID:", facultyId!),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(height: 1),
                          ),
                          ...cart.entries.map((e) {
                            int unitPrice = itemPrices[e.key] ?? 0;
                            return _row("${e.key} x${e.value}", "₹${unitPrice * e.value}");
                          }),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(thickness: 2, color: Color(0xFFF3F3F3)),
                          ),
                          _row("TOTAL AMOUNT", "₹$grandTotal", isBold: true, isRed: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // --- ADDED CAUTION FOR STUDENTS ---
              if (role == "Student")
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Please collect your order within 30 minutes, or it will be automatically canceled.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFE23744), 
                      fontWeight: FontWeight.bold, 
                      fontSize: 12,
                    ),
                  ),
                ),

              const SizedBox(height: 40),
              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE23744),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemListPage(
                          role: role, 
                          userId: facultyId ?? "Student",
                        ),
                      ),
                      (route) => route.isFirst,
                    );
                  },
                  child: const Text("DONE", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool isBold = false, bool isRed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(
            fontSize: 14, 
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? Colors.black : Colors.grey[700]
          )),
          Text(value, style: TextStyle(
            fontSize: isBold ? 18 : 14, 
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w600,
            color: isRed ? const Color(0xFFE23744) : Colors.black
          )),
        ],
      ),
    );
  }
}