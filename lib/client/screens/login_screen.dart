import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/widgets/button_custom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Import ProfileScreen
import '../screens/register_screen.dart'; // Import RegisterScreen

import '../widgets/nav.dart'; // Import NavBar

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hiddenPassword = true;
  bool _loading = false;
  String? _errorMessage;

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<void> _login(BuildContext context) async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final String username = _usernameController.text;
    final String password = _passwordController.text;
    String host = '192.168.1.13';
    final response = await http.post(
      Uri.parse('http://$host:3000/login'), // Replace with your server URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    setState(() {
      _loading = false;
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final String token = responseBody['token'];

      // Lưu token vào SharedPreferences
      await _saveToken(token);

      // Navigate to NavBar upon successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavBar(token: token)),
      );
    } else {
      // Handle error
      setState(() {
        _errorMessage = 'Đăng nhập không thành công. Vui lòng thử lại.';
      });
      print('Login failed, status code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng nhập',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 92, 52),
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
                  labelText: 'Email/Số điện thoại',
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
                  label: 'Đăng nhập',
                  onPressed: _loading ? null : () => _login(context)),
              const SizedBox(height: 10.0),
              ContainerButton(
                label: 'Đăng ký',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
              ),
              const SizedBox(height: 90.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password logic
                    },
                    child: const Text(
                      'quên mật khẩu?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement Google sign-in logic
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blueAccent),
                    ),
                    child: const Text(
                      'Đăng nhập với Google',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
