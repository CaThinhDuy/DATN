import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/standard_UI.dart';

class NotificationNoToken extends StatelessWidget {
  const NotificationNoToken({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Thông báo ',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: UI.backgroundApp),
      body: const Center(child: Text('Vui lòng đăng nhập để xem thông báo.')),
    );
  }
}
