import 'package:flutter/material.dart';

import 'client/widgets/nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My App',
      home: NavBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
