import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/screens/foods_screen.dart';
import 'package:shopping_app/screens/groceries_screen.dart';
import 'package:shopping_app/screens/clothes_screen.dart';
import 'package:shopping_app/screens/electronics_screen.dart';

class HomeScreen extends StatefulWidget {
  
  final List<Product> cart;
  final Function(Product) addToCart;
  final Function(Product) removeFromCart;
  final Function clearCart;

  const HomeScreen({
    super.key,
    required this.cart,
    required this.addToCart,
    required this.removeFromCart,
    required this.clearCart,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<String> _ads = [
    'assets/images/ad1.jpg',
    'assets/images/ad2.jpg',
    'assets/images/ad3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < _ads.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'Foods',
        'image': 'assets/images/foods.jpg',
        'screen': FoodsScreen(
          cart: widget.cart,
          addToCart: widget.addToCart,
          removeFromCart: widget.removeFromCart,
          clearCart: widget.clearCart,
        ),
      },
      {
        'title': 'Groceries',
        'image': 'assets/images/groceries.jpg',
        'screen': GroceriesScreen(
          cart: widget.cart,
          addToCart: widget.addToCart,
          removeFromCart: widget.removeFromCart,
          clearCart: widget.clearCart,
        ),
      },
      {
        'title': 'Clothes',
        'image': 'assets/images/clothes.jpg',
        'screen': ClothesScreen(
          cart: widget.cart,
          addToCart: widget.addToCart,
          removeFromCart: widget.removeFromCart,
          clearCart: widget.clearCart,
        ),
      },
      {
        'title': 'Electronics',
        'image': 'assets/images/electronics.jpg',
        'screen': ElectronicsScreen(
          cart: widget.cart,
          addToCart: widget.addToCart,
          removeFromCart: widget.removeFromCart,
          clearCart: widget.clearCart,
        ),
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Online Shopping')),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _ads.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      _ads[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () => _navigateToScreen(context, category['screen']),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            child: Image.asset(
                              category['image'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            category['title'],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    );
  }
}
