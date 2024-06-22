import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/screens/product_detail_screen.dart';
import 'package:flutter_application_1/client/widgets/nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: ProductDetailScreen(
          product: Product(
              name: 'sp1',
              imageUrl:
                  'https://product.hstatic.net/200000722513/product/121d2924a3581e9be47de263576_6fb825a51a744d3c82e4aa7eed9cc1d2_1024x1024_23db2166e8714c008b17744e32b1b190_1024x1024.jpg',
              price: 1000,
              description: 'description sp 1')),
      debugShowCheckedModeBanner: false,
    );
  }
}
