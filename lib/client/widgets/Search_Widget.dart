import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 92, 52),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.search,
            color: Colors.white,
          ),
          const SizedBox(
              width: 8), // Khoảng cách giữa icon search và text field
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8), // Khoảng cách giữa text field và icon cart
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              _navigateToCart(context);
            },
          ),
        ],
      ),
    );
  }
}
