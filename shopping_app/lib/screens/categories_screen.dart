import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'foods_screen.dart';
import 'groceries_screen.dart';
import 'clothes_screen.dart';
import 'electronics_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Product> cart;
  final Function(Product) addToCart;
  final Function(Product) removeFromCart;
  final Function clearCart;

  const CategoriesScreen({
    super.key,
    required this.cart,
    required this.addToCart,
    required this.removeFromCart,
    required this.clearCart,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'name': 'Foods',
        'icon': Icons.fastfood,
        'screen': FoodsScreen(
          cart: cart,
          addToCart: addToCart,
          removeFromCart: removeFromCart,
          clearCart: clearCart,  // Passing clearCart function here
        )
      },
      {
        'name': 'Groceries',
        'icon': Icons.local_grocery_store,
        'screen': GroceriesScreen(
          cart: cart,
          addToCart: addToCart,
          removeFromCart: removeFromCart,
          clearCart: clearCart,  // Passing clearCart function here
        )
      },
      {
        'name': 'Clothes',
        'icon': Icons.checkroom,
        'screen': ClothesScreen(
          cart: cart,
          addToCart: addToCart,
          removeFromCart: removeFromCart,
          clearCart: clearCart,  // Passing clearCart function here
        )
      },
      {
        'name': 'Electronics',
        'icon': Icons.devices,
        'screen': ElectronicsScreen(
          cart: cart,
          addToCart: addToCart,
          removeFromCart: removeFromCart,
          clearCart: clearCart,  // Passing clearCart function here
        )
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => category['screen']),
              );
            },
            child: Card(
              color: Colors.blueGrey[50],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category['icon'],
                    size: 60,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    category['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
