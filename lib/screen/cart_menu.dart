import 'package:flutter/material.dart';
import 'package:sketch/screen/cart.dart';
import 'package:provider/provider.dart';
import 'package:sketch/models/cart.dart';

class MenuScreen extends StatelessWidget {
  final List<String> menuItems = [
    'Pizza',
    'Burger',
    'Pasta',
    'Salad',
    'Soup',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Menu'),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      if (cart.items.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cart is empty')),
                        );
                      }
                    },
                  ),
                  if (cart.items.isNotEmpty)
                    Positioned(
                      right: 17.5,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '${cart.items.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(menuItems[index]),
                trailing: const Icon(Icons.add),
                onTap: () {
                  Provider.of<CartModel>(context, listen: false)
                      .addItem(menuItems[index]);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('${menuItems[index]} added to cart')),
                  );
                },
              );
            },
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.of(context).pushReplacement(MaterialPageRoute(
          //         builder: (context) => MapScreen(),
          //       ));
          //     },
          //     child: Text('Go to Map Screen')),
        ],
      ),
    );
  }
}
