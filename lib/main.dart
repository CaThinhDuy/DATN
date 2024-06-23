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
      home: NavBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
