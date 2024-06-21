import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/widgets/Search_Widget.dart';
import 'package:flutter_application_1/client/widgets/button_custom.dart';
import 'package:flutter_application_1/client/widgets/page_view_slider.dart';

import 'package:flutter_application_1/client/widgets/widgets_slider_js.dart';

// Define the Product class
class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });
}

// Product Detail Screen widget
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            SizedBox(height: 8),
            ContainerButton(
              label: 'Mua ngay',
              onPressed: () {
                //xu ly chuyen trang thanh toan
              },
              icon: Icons.shopping_cart_rounded,
            ),
            SizedBox(height: 8),
            ContainerButton(
              label: 'Thêm vào giỏ',
              onPressed: () {
                //xu ly chuyen trang gio hang
              },
              icon: Icons.add_shopping_cart_sharp,
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      // bottomSheet: NavBar(),
    );
  }
}
