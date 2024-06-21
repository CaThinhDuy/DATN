import 'package:flutter/material.dart';

import 'widgets/nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'My App',
      home: NavBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
