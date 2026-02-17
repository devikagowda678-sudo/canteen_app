import 'package:flutter/material.dart';
import 'upi_processing_page.dart';
import 'net_banking_page.dart';

class OnlinePaymentPage extends StatelessWidget {
  final Map<String, int> cart;
  final String role;
  final String location;
  final String facultyId;

  const OnlinePaymentPage({
    super.key, 
    required this.cart, 
    required this.role, 
    required this.location,
    required this.facultyId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Online Payment"), backgroundColor: Colors.blueAccent),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.qr_code_scanner),
            title: const Text("UPI (GPay / PhonePe / Paytm)"),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (c) => UPIProcessingPage(cart: cart, role: role, location: location, facultyId: facultyId)
            )),
          ),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text("Net Banking"),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (c) => NetBankingPage(cart: cart, role: role, location: location, facultyId: facultyId)
            )),
          ),
        ],
      ),
    );
  }
}