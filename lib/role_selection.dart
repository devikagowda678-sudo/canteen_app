import 'package:flutter/material.dart';
import 'login_page.dart';
import 'admin_page.dart'; // Make sure this is imported

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Changed to full Red background
      backgroundColor: const Color(0xFFE23744), 
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              // --- SECRET ADMIN ACCESS START ---
              GestureDetector(
                onLongPress: () {
                  // Logic kept exactly same
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminPage()),
                  );
                },
                child: const Icon(
                  Icons.restaurant_menu, 
                  size: 100, // Slightly bigger to look professional
                  color: Colors.white // Icon changed to White
                ),
              ),
              // --- SECRET ADMIN ACCESS END ---

              const SizedBox(height: 20),
              const Text(
                "COLLEGE CANTEEN",
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.w900, // Bolder for Zomato look
                  color: Colors.white, // Text changed to White
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 60),

              // Student Button - Now White background with Red text
              _roleButton(
                context,
                title: "STUDENT",
                role: "Student",
                color: Colors.white, 
                textColor: const Color(0xFFE23744),
                icon: Icons.school,
              ),

              const SizedBox(height: 20),

              // Faculty Button - Now Outlined/Secondary style
              _roleButton(
                context,
                title: "FACULTY",
                role: "Faculty",
                color: Colors.transparent, 
                textColor: Colors.white,
                icon: Icons.person_pin,
                isSecondary: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Modified helper to support the new Red/White theme
  Widget _roleButton(BuildContext context, {
    required String title, 
    required String role, 
    required Color color, 
    required Color textColor,
    required IconData icon,
    bool isSecondary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: isSecondary ? 0 : 4,
          side: isSecondary ? const BorderSide(color: Colors.white, width: 2) : BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        icon: Icon(icon, color: textColor),
        label: Text(
          title, 
          style: TextStyle(
            color: textColor, 
            fontSize: 18, 
            fontWeight: FontWeight.bold
          )
        ),
        onPressed: () {
          // Navigation logic kept exactly same
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage(initialRole: role)),
          );
        },
      ),
    );
  }
}