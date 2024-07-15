// lib/screens/register_screen.dart
import 'package:flutter/material.dart';

import 'package:flutter_application_1/utils/standard_UI.dart';

import '../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng ký',
          style: TextStyle(
              color: UI.wordTile,
              fontSize: UI.wordTileSize,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: UI.backgroundApp,
        iconTheme:
            const IconThemeData(color: UI.wordTile, size: UI.wordTileSize),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: RegisterForm(),
        ),
      ),
    );
  }
}
