import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  final double totalAmount;
  final String paymentMethod;

  const OtpPage({
    super.key,
    required this.totalAmount,
    required this.paymentMethod,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController otpController = TextEditingController();

  void verifyOTP() {
    if (otpController.text == "1234") {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Payment Successful ✅"),
          content: Text(
            "₹${widget.totalAmount.toStringAsFixed(2)} paid successfully via ${widget.paymentMethod}",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Back to previous screen
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP ❌"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),

            Text(
              "Enter OTP to Pay ₹${widget.totalAmount.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter OTP",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: verifyOTP,
                child: const Text(
                  "Verify OTP",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Demo OTP: 1234",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
