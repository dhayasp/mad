import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/screens/cart_screen.dart';

final List<Product> clothesList = [
  Product(name: 'Shirt', imageUrl: 'assets/images/shirt.jpg', price: 500.0),
  Product(name: 'Jeans', imageUrl: 'assets/images/jeans.jpg', price: 1000.0),
  Product(name: 'T-shirt', imageUrl: 'assets/images/tshirt.jpg', price: 400.0),
  Product(name: 'Jacket', imageUrl: 'assets/images/jacket.jpg', price: 1500.0),
  Product(name: 'Saree', imageUrl: 'assets/images/saree.jpg', price: 3000.0),
  Product(name: 'Dhosthi', imageUrl: 'assets/images/vesti.jpg', price: 1000.0),
  Product(name: 'Churidar', imageUrl: 'assets/images/churidar.jpg', price: 1500.0),
];

class ClothesScreen extends StatefulWidget {
  final List<Product> cart;
  final Function(Product) addToCart;
  final Function(Product) removeFromCart;
  final Function clearCart;

  const ClothesScreen({
    super.key,
    required this.cart,
    required this.addToCart,
    required this.removeFromCart,
    required this.clearCart,
  });

  @override
  State<ClothesScreen> createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  String searchQuery = '';
  String sortOption = 'None';

  List<Product> get filteredClothes {
    List<Product> filtered = clothesList
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
        title: const Text('Clothes'),
        actions: [
          DropdownButton<String>(
            value: sortOption,
            underline: Container(),
            onChanged: (value) {
              setState(() => sortOption = value!);
            },
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
                hintText: 'Search clothes...',
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
        itemCount: filteredClothes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final product = filteredClothes[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
