import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketch/models/cart.dart';


class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text('No items in the cart'))
          : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cart.items[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      cart.removeItem(cart.items[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('${cart.items[index]} removed from cart')),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
