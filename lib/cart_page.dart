import 'package:flutter/material.dart';
import 'payment_page.dart';

class CartPage extends StatelessWidget {
  final Map<String, int> selectedItems;
  final String role;

  const CartPage({super.key, required this.selectedItems, required this.role});

  final Map<String, int> itemPrices = const {
    "Full Veg Meals": 70,
    "Mini North Indian Meals": 60,
    "Veg Fried Rice": 50,
    "Paneer Biryani": 80,
    "Jeera Rice & Dal": 55,
    "Bisi Bele Bath": 40,
    "Set Dosa": 30,
    "Masala Dosa": 45,
    "Idli Vada (2+1)": 35,
    "Poori Sabji": 40,
    "Parota (2 pcs)": 50,
    "Rice Bath": 30,
    "Veg Puff": 15,
    "Samosa": 12,
    "Bread Omlette": 35,
    "Mangalore Bajji": 25,
    "Tea": 10,
    "Coffee": 12,
    "Badam Milk": 15,
    "Fruit Salad": 30,
  };

  double calculateTotal() {
    double total = 0;
    selectedItems.forEach((name, qty) => total += (itemPrices[name] ?? 0) * qty);
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Summary")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                String name = selectedItems.keys.elementAt(index);
                int qty = selectedItems[name]!;
                return ListTile(
                  title: Text(name),
                  subtitle: Text("Qty: $qty x ₹${itemPrices[name]}"),
                  trailing: Text("₹${qty * (itemPrices[name] ?? 0)}"),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("₹${calculateTotal()}", style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(
                      builder: (c) => PaymentPage(cart: selectedItems, role: role),
                    )),
                    child: const Text("PROCEED TO PAYMENT"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}