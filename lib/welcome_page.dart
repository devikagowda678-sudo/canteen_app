import 'package:flutter/material.dart';
import 'role_selection.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White Background
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- COLLEGE LOGO FROM INTERNET ---
            Image.network(
              'https://www.sabs.ac.in/images/logo.png', // Official SABS Logo
              height: 120,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.school_rounded,
                size: 80,
                color: Color(0xFFE23744),
              ),
            ),
            const SizedBox(height: 30),

            // --- COLLEGE NAME ---
            const Text(
              "SESHADRIPURAM ACADEMY OF BUSINESS STUDIES",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE23744), // Red Text
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 15),

            // --- WELCOME TEXT ---
            const Text(
              "Welcome to\nCollege Canteen",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1C1C1C), // Bold Black
                height: 1.2,
              ),
            ),
            const SizedBox(height: 60),

            // --- GET STARTED BUTTON ---
            SizedBox(
              width: 220,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE23744), // Zomato Red Button
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RoleSelectionPage()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("GET STARTED", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}