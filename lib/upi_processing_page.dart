import 'package:flutter/material.dart';
import 'success_page.dart';

class UPIProcessingPage extends StatefulWidget {
  final Map<String, int> cart;
  final String role;
  final String location;
  final String facultyId; // <--- The "pocket" must be here

  const UPIProcessingPage({
    super.key, 
    required this.cart, 
    required this.role, 
    required this.location,
    required this.facultyId, // <--- And here
  });

  @override
  State<UPIProcessingPage> createState() => _UPIProcessingPageState();
}

class _UPIProcessingPageState extends State<UPIProcessingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (c) => SuccessPage(
              cart: widget.cart,
              role: widget.role,
              paymentMethod: "Online (UPI)",
              location: widget.location,
              facultyId: widget.facultyId, // Passing it to the end
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(height: 20),
            Text("Verifying UPI Transaction...", 
              style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}