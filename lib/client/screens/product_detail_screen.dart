import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/widgets/Search_Widget.dart';
import 'package:flutter_application_1/client/widgets/button_custom.dart';

// Define the Product class
class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  Product(
      {required this.name,
      required this.imageUrl,
      required this.price,
      required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'],
        imageUrl: json['imageUrl'],
        price: json['price'].toDouble(),
        description: json['description']);
  }
}

// Product Detail Screen widget
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 92, 52),
        title: SearchWidget(),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerButton(
                    label: 'Mua ngay',
                    onPressed: () {
                      //xu ly chuyen trang thanh toan
                    },
                    icon: Icons.shopping_cart_rounded,
                  ),
                  ContainerButton(
                    label: 'Thêm vào giỏ',
                    onPressed: () {
                      //xu ly chuyen trang gio hang
                    },
                    icon: Icons.add_shopping_cart_sharp,
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
      ),
      // bottomSheet: NavBar(),
    );
  }
}
