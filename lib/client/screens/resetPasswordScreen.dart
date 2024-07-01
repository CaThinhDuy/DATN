import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/widgets/button_custom.dart';
import 'package:flutter_application_1/client/widgets/nav.dart';
import 'package:flutter_application_1/utils/api.dart';
import 'package:flutter_application_1/utils/standard_UI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../server/UserService.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _resetPassword() async {
    bool _loading = false;
    String? _errorMessage;

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final String token = _tokenController.text;
    final String newPassword = _passwordController.text;
    final success = await UserService.resetPassWord(token, newPassword);

    setState(() {
      _loading = false;
    });

    if (success) {
      const SnackBar(content: Text('Thay đổi mật khẩu thành công'));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => NavBar()),
        (route) => false,
      );
    } else {
      setState(() {
        _errorMessage = 'Thay đổi mật khẩu thất bại';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UI.backgroundApp,
        title: const Text(
          'Đặt lại mật khẩu',
          style: TextStyle(
              fontSize: UI.wordTileSize,
              color: UI.wordTile,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/logo2.png',
              cacheHeight: 180,
              cacheWidth: 200,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _tokenController,
              decoration:
                  const InputDecoration(labelText: 'Mã đặt lại mật khẩu'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mật khẩu mới'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ContainerButton(
              onPressed: _resetPassword,
              label: 'Đặt lại mật khẩu',
            ),
          ],
        ),
      ),
    );
  }
}
