import 'package:flutter/material.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body: const Center(
        child: Text('Màn hình thanh toán'),
      ),
    );
  }
}
