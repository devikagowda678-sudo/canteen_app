import 'package:flutter/material.dart';
import 'main.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // Tab 1: Logic remains—all non-delivered orders
    final liveKitchen = globalOrders.where((o) => o['status'] != "Delivered").toList();
    
    // Tab 2: Fixed Logic—Check if payment string CONTAINS "Pay Later"
    final staffLedger = globalOrders.where((o) => 
      o['payment'].toString().contains("Pay Later")).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Admin Dashboard", 
          style: TextStyle(color: Color(0xFF1C1C1C), fontWeight: FontWeight.w900, fontSize: 24)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFE23744), // Zomato Red
          indicatorWeight: 3,
          labelColor: const Color(0xFFE23744),
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          tabs: [
            Tab(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("LIVE KITCHEN"),
                if (liveKitchen.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: const Color(0xFFE23744),
                    child: Text(liveKitchen.length.toString(), 
                      style: const TextStyle(color: Colors.white, fontSize: 10)),
                  )
                ]
              ],
            )),
            const Tab(text: "STAFF LEDGER"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(liveKitchen, isLedger: false),
          _buildOrderList(staffLedger, isLedger: true),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<dynamic> orders, {required bool isLedger}) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey.shade200),
            const SizedBox(height: 16),
            Text(isLedger ? "No pending dues." : "Kitchen queue is empty.",
              style: TextStyle(color: Colors.grey.shade400, fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order #${order['id']}", 
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                        Text(order['role'] ?? "Student", 
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Text("₹${order['total']}", 
                      style: const TextStyle(color: Color(0xFF1C1C1C), fontWeight: FontWeight.w900, fontSize: 18)),
                  ],
                ),
              ),
              const Divider(height: 1),
              
              // Details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (order['facultyId'] != null && order['facultyId'] != "")
                      _infoRow(Icons.person, "ID: ${order['facultyId']}", Colors.blue),
                    _infoRow(Icons.location_on, order['location'], Colors.orange),
                    const SizedBox(height: 12),
                    const Text("ITEMS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
                    const SizedBox(height: 8),
                    ...(order['items'] as Map<String, int>).entries.map((e) => 
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            const Icon(Icons.fiber_manual_record, size: 8, color: Colors.green),
                            const SizedBox(width: 8),
                            Text("${e.key} x${e.value}", style: const TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: isLedger 
                  ? _actionButton("MARK AS PAID", const Color(0xFF24963F), () {
                      setState(() => globalOrders.removeWhere((o) => o['id'] == order['id']));
                    })
                  : Row(
                      children: [
                        Expanded(child: _actionButton("CANCEL", Colors.grey.shade100, () {
                          setState(() => globalOrders.removeWhere((o) => o['id'] == order['id']));
                        }, textColor: Colors.grey.shade700)),
                        const SizedBox(width: 12),
                        Expanded(child: _actionButton("DELIVER", const Color(0xFFE23744), () {
                          setState(() => order['status'] = "Delivered");
                        })),
                      ],
                    ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _infoRow(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _actionButton(String label, Color color, VoidCallback onTap, {Color textColor = Colors.white}) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        child: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w900, letterSpacing: 0.8)),
      ),
    );
  }
}