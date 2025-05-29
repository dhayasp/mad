import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cart;
  final Function(Product) removeFromCart;
  final Function clearCart;

  const CartScreen({
    super.key,
    required this.cart,
    required this.removeFromCart,
    required this.clearCart,
  });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _calculateTotal(List<Product> cart) {
    double total = 0;
    for (var product in cart) {
      total += product.price;
    }
    return total;
  }

  void _clearCartAndRefresh() {
    widget.clearCart();
    setState(() {}); // Refresh the UI
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cart cleared')),
    );
  }

  @override
  Widget build(BuildContext context) {
    double total = _calculateTotal(widget.cart);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          if (widget.cart.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Clear Cart'),
                      content: const Text('Are you sure you want to clear the cart?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _clearCartAndRefresh();
                          },
                          child: const Text('Clear'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
        ],
      ),
      body: widget.cart.isEmpty
          ? const Center(child: Text('Your cart is empty', style: TextStyle(fontSize: 18)))
          : ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final product = widget.cart[index];
                return ListTile(
                  leading: Image.asset(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(product.name),
                  subtitle: Text('₹${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                    onPressed: () {
                      widget.removeFromCart(product);
                      setState(() {}); // Refresh after removal
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} removed from cart')),
                      );
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: widget.cart.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.deepPurple,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total: ₹${total.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontSize: 18)),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Bill'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (var product in widget.cart)
                                    Text('${product.name}: ₹${product.price.toStringAsFixed(2)}'),
                                  const SizedBox(height: 20),
                                  Text('Total: ₹${total.toStringAsFixed(2)}',
                                      style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
