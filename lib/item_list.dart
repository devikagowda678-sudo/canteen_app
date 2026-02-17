import 'package:flutter/material.dart';
import 'payment_page.dart';

class ItemListPage extends StatefulWidget {
  final String role;
  final String userId;
  const ItemListPage({super.key, required this.role, required this.userId});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  final Map<String, int> cart = {};
  String _searchQuery = "";

  final List<Map<String, dynamic>> items = [
    {"name": "Full Veg Meals", "price": 70, "cat": "Meals"},
    {"name": "Mini North Indian Meals", "price": 60, "cat": "Meals"},
    {"name": "Veg Fried Rice", "price": 50, "cat": "Rice"},
    {"name": "Paneer Biryani", "price": 80, "cat": "Rice"},
    {"name": "Jeera Rice & Dal", "price": 55, "cat": "Rice"},
    {"name": "Bisi Bele Bath", "price": 40, "cat": "Breakfast"},
    {"name": "Set Dosa", "price": 30, "cat": "Breakfast"},
    {"name": "Masala Dosa", "price": 45, "cat": "Breakfast"},
    {"name": "Idli Vada (2+1)", "price": 35, "cat": "Breakfast"},
    {"name": "Poori Sabji", "price": 40, "cat": "Breakfast"},
    {"name": "Parota (2 pcs)", "price": 50, "cat": "Breakfast"},
    {"name": "Rice Bath", "price": 30, "cat": "Breakfast"},
    {"name": "Veg Puff", "price": 15, "cat": "Snacks"},
    {"name": "Samosa", "price": 12, "cat": "Snacks"},
    {"name": "Bread Omlette", "price": 35, "cat": "Snacks"},
    {"name": "Mangalore Bajji", "price": 25, "cat": "Snacks"},
    {"name": "Tea", "price": 10, "cat": "Drinks"},
    {"name": "Coffee", "price": 12, "cat": "Drinks"},
    {"name": "Badam Milk", "price": 15, "cat": "Drinks"},
    {"name": "Fruit Salad", "price": 30, "cat": "Dessert"},
  ];

  double _getGrandTotal() {
    double total = 0;
    cart.forEach((name, qty) {
      final item = items.firstWhere((i) => i['name'] == name);
      total += (item['price'] * qty);
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((i) => i['name'].toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    double totalAmt = _getGrandTotal();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text("Order for ${widget.userId}"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: "Search for dishes...",
                prefixIcon: const Icon(Icons.search, color: Color(0xFFE23744)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                int count = cart[item['name']] ?? 0;
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 4),
                              Text("₹${item['price']}", style: const TextStyle(color: Colors.black87, fontSize: 14)),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE23744)),
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFFFF5F5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, color: Color(0xFFE23744), size: 18),
                                onPressed: () => setState(() => cart[item['name']] = count > 0 ? count - 1 : 0),
                              ),
                              Text("$count", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE23744))),
                              IconButton(
                                icon: const Icon(Icons.add, color: Color(0xFFE23744), size: 18),
                                onPressed: () => setState(() => cart[item['name']] = count + 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: totalAmt > 0 ? Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(
            builder: (c) => PaymentPage(
              cart: cart, 
              role: widget.role, 
              location: "Main Canteen", 
              loginId: widget.userId,    // Added loginId
              facultyId: widget.userId,  // Added facultyId (Fixes the error)
            )
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${cart.length} ITEMS", style: const TextStyle(fontSize: 14)),
              Row(
                children: [
                  const Text("PROCEED"),
                  const SizedBox(width: 8),
                  Text("₹$totalAmt", style: const TextStyle(fontSize: 18)),
                ],
              ),
            ],
          ),
        ),
      ) : null,
    );
  }
}