import 'package:flutter/material.dart';
import 'item_list.dart';

class LoginPage extends StatefulWidget {
  final String? initialRole;
  const LoginPage({super.key, this.initialRole});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  late String _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole ?? "Student";
  }

  void _handleLogin() {
    String id = _idController.text.trim().toUpperCase();

    if (id.isEmpty) {
      _showCaution("Caution: ID cannot be empty!");
      return;
    }

    // STRICT VALIDATION LOGIC PRESERVED
    if (_selectedRole == "Student") {
      if (!id.startsWith("26S00")) {
        _showCaution("Access Denied: Student IDs must start with 26S00");
        return;
      }
    } else if (_selectedRole == "Faculty") {
      if (!id.startsWith("26F00")) {
        _showCaution("Access Denied: Faculty IDs must start with 26F00");
        return;
      }
    }

    Navigator.push(
      context, 
      MaterialPageRoute(builder: (c) => ItemListPage(role: _selectedRole, userId: id))
    );
  }

  void _showCaution(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFE23744), // Zomato Red
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Canteen Login"),
        // Style handled by main.dart theme
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text("Welcome back!", 
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF2D2D2D))),
            const Text("Please login to your account", 
              style: TextStyle(fontSize: 16, color: Colors.grey)),
            
            const SizedBox(height: 40),
            
            // MODERN ROLE SELECTOR
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  _buildRoleTab("Student"),
                  _buildRoleTab("Faculty"),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // CUSTOM ZOMATO INPUT
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
                ],
              ),
              child: TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: "Identification ID",
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: _selectedRole == "Student" ? "e.g. 26S001" : "e.g. 26F001",
                  prefixIcon: const Icon(Icons.badge_outlined, color: Color(0xFFE23744)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(18),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // ZOMATO RED BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE23744),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                ),
                onPressed: _handleLogin,
                child: const Text("CONTINUE", 
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for the Toggle Design
  Widget _buildRoleTab(String role) {
    bool isSelected = _selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedRole = role),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected 
              ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)] 
              : [],
          ),
          child: Center(
            child: Text(
              role,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFFE23744) : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}