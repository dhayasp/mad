import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/screens/cart_screen.dart';

final List<Product> electronicsList = [
  Product(name: 'Smartphone', imageUrl: 'assets/images/phone.jpg', price: 9999.0),
  Product(name: 'Headphones', imageUrl: 'assets/images/headphones.jpg', price: 1999.0),
  Product(name: 'Tv', imageUrl: 'assets/images/tv.jpg', price: 20000.0),
  Product(name: 'Watch', imageUrl: 'assets/images/watch.jpg', price: 1999.0),
  Product(name: 'Fan', imageUrl: 'assets/images/fan.jpg', price: 2500.0),
  Product(name: 'Tab', imageUrl: 'assets/images/tab.jpg', price: 15000.0),
  Product(name: 'Camera', imageUrl: 'assets/images/camera.jpg', price: 40000.0),
  Product(name: 'Iron box', imageUrl: 'assets/images/ironbox.jpg', price: 1500.0),
];

class ElectronicsScreen extends StatefulWidget {
  final List<Product> cart;
  final Function(Product) addToCart;
  final Function(Product) removeFromCart;
  final Function clearCart;

  const ElectronicsScreen({
    super.key,
    required this.cart,
    required this.addToCart,
    required this.removeFromCart,
    required this.clearCart,
  });

  @override
  State<ElectronicsScreen> createState() => _ElectronicsScreenState();
}

class _ElectronicsScreenState extends State<ElectronicsScreen> {
  String searchQuery = '';
  String sortOption = 'None';

  List<Product> get filteredElectronics {
    List<Product> filtered = electronicsList
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
        title: const Text('Electronics'),
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
                hintText: 'Search electronics...',
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
        padding: const EdgeInsets.all(10),
        itemCount: filteredElectronics.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final product = filteredElectronics[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Column(
              children: [
                Expanded(child: Image.asset(product.imageUrl, fit: BoxFit.cover)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                Text('₹${product.price.toStringAsFixed(2)}'),
                ElevatedButton(
                  onPressed: () {
                    widget.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} added to cart!')),
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
