import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/button_custom.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _hiddenPassword = true;
  bool _loading = false;
  String? _errorMessage;

  Future<void> _register(BuildContext context) async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String email = _emailController.text;
    String host = '192.168.1.13'; // Replace with your server IP

    final response = await http.post(
      Uri.parse('http://${host}:3000/register'), // Replace with your server URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'email': email,
      }),
    );

    setState(() {
      _loading = false;
    });

    if (response.statusCode == 200) {
      // Successful registration
      Navigator.pop(context); // Go back to login screen
    } else {
      // Handle error
      setState(() {
        _errorMessage = 'Đăng ký không thành công. Vui lòng thử lại.';
      });
      print('Register failed, status code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng ký',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 92, 52),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo2.png',
                cacheHeight: 180,
                cacheWidth: 200,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_circle_outlined),
                  labelText: 'Tên đăng nhập',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.password),
                    labelText: 'Mật khẩu',
                    suffixIcon: IconButton(
                      icon: Icon(_hiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _hiddenPassword = !_hiddenPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _hiddenPassword,
                ),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 16.0),
              ContainerButton(
                label: 'Đăng ký',
                onPressed: _loading ? null : () => _register(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
