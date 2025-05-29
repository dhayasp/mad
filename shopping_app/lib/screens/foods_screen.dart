import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/screens/cart_screen.dart';

final List<Product> foodsList = [
  Product(name: 'Burger', imageUrl: 'assets/images/burger.jpg', price: 99.0),
  Product(name: 'Pizza', imageUrl: 'assets/images/pizza.jpg', price: 149.0),
  Product(name: 'Pasta', imageUrl: 'assets/images/pasta.jpg', price: 129.0),
  Product(name: 'Fries', imageUrl: 'assets/images/fries.jpg', price: 90.0),
  Product(name: 'Briyani', imageUrl: 'assets/images/briyani.jpg', price: 100.0),
  Product(name: 'Dosa', imageUrl: 'assets/images/dosa.jpg', price: 60.0),
];

class FoodsScreen extends StatefulWidget {
  final List<Product> cart;
  final Function(Product) addToCart;
  final Function(Product) removeFromCart;
  final Function clearCart;

  const FoodsScreen({
    super.key,
    required this.cart,
    required this.addToCart,
    required this.removeFromCart,
    required this.clearCart,
  });

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  String searchQuery = '';
  String sortOption = 'None';

  List<Product> get filteredFoods {
    List<Product> filtered = foodsList
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
        title: const Text('Foods'),
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
                hintText: 'Search foods...',
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
        itemCount: filteredFoods.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final product = filteredFoods[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(product.imageUrl, fit: BoxFit.cover),
                ),
                const SizedBox(height: 8),
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('₹${product.price.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Item added to cart!'), duration: Duration(seconds: 1)),
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
