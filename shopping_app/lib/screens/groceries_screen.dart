import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/screens/cart_screen.dart';

final List<Product> groceriesList = [
  Product(name: 'Rice', imageUrl: 'assets/images/rice.jpg', price: 60.0),
  Product(name: 'Milk', imageUrl: 'assets/images/milk.jpg', price: 30.0),
  Product(name: 'Apple', imageUrl: 'assets/images/apple.jpg', price: 30.0),
  Product(name: 'Shampoo', imageUrl: 'assets/images/shampoo.jpg', price: 30.0),
  Product(name: 'Biscuit', imageUrl: 'assets/images/biscuit.jpg', price: 30.0),
  Product(name: 'Sugar', imageUrl: 'assets/images/sugar.jpg', price: 30.0),
  Product(name: 'Cooking Oil', imageUrl: 'assets/images/oil.jpg', price: 30.0),
  Product(name: 'Toothpaste', imageUrl: 'assets/images/toothpaste.jpg', price: 30.0),
];

class GroceriesScreen extends StatefulWidget {
  final List<Product> cart;
  final Function(Product) addToCart;
  final Function(Product) removeFromCart;
  final Function clearCart;

  const GroceriesScreen({
    super.key,
    required this.cart,
    required this.addToCart,
    required this.removeFromCart,
    required this.clearCart,
  });

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  String searchQuery = '';
  String sortOption = 'None';

  List<Product> get filteredGroceries {
    List<Product> filtered = groceriesList
        .where((product) => product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    if (sortOption == 'Name') {
      filtered.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortOption == 'Price: Low to High') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortOption == 'Price: High to Low') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries'),
        actions: [
          DropdownButton<String>(
            value: sortOption,
            underline: Container(),
            onChanged: (value) => setState(() => sortOption = value!),
            items: ['None', 'Name', 'Price: Low to High', 'Price: High to Low']
                .map((option) => DropdownMenuItem(value: option, child: Text(option)))
                .toList(),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cart: widget.cart,
                    removeFromCart: widget.removeFromCart,
                    clearCart: widget.clearCart,
                  ),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search groceries...',
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: filteredGroceries.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final product = filteredGroceries[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(child: Image.asset(product.imageUrl, fit: BoxFit.cover)),
                const SizedBox(height: 8),
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('₹${product.price.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} added to cart')),
                    );
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
