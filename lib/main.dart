import 'package:flutter/material.dart';
import 'welcome_page.dart'; // Added this import
import 'role_selection.dart';

// Shared data list for Admin and Success pages - Kept exactly as is
List<Map<String, dynamic>> globalOrders = [];

void main() => runApp(const ZomatoStyleCanteen());

class ZomatoStyleCanteen extends StatelessWidget {
  const ZomatoStyleCanteen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Canteen App',
      
      // Global Theme Settings (Your Zomato Red Design)
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        
        primaryColor: const Color(0xFFE23744), // Zomato Red
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE23744),
          primary: const Color(0xFFE23744), 
          surface: Colors.white,
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 8,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE23744),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE23744),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFE23744), width: 2),
          ),
        ),
      ),
      
      // POINTING TO THE NEW WELCOME PAGE FIRST
      home: const WelcomePage(), 
    );
  }
}