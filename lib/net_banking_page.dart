import 'package:flutter/material.dart';
import 'success_page.dart';

class NetBankingPage extends StatefulWidget {
  final Map<String, int> cart;
  final String role;
  final String location;
  final String facultyId;

  const NetBankingPage({
    super.key, 
    required this.cart, 
    required this.role, 
    required this.location,
    required this.facultyId,
  });

  @override
  State<NetBankingPage> createState() => _NetBankingPageState();
}

class _NetBankingPageState extends State<NetBankingPage> {
  String? selectedBank;
  final List<String> banks = ["SBI", "HDFC", "ICICI", "Axis Bank"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Net Banking"), backgroundColor: Colors.indigo),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: banks.length,
              itemBuilder: (context, index) => RadioListTile(
                title: Text(banks[index]),
                value: banks[index],
                groupValue: selectedBank,
                onChanged: (v) => setState(() => selectedBank = v as String),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                onPressed: selectedBank == null ? null : () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (c) => SuccessPage(
                      cart: widget.cart,
                      role: widget.role,
                      paymentMethod: "Net Banking",
                      location: widget.location,
                      facultyId: widget.facultyId,
                    )
                  ));
                },
                child: const Text("PAY NOW", style: TextStyle(color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}