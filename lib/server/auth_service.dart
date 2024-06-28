import 'package:flutter_application_1/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../client/widgets/nav.dart'; // Import NavBar

class AuthService {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  static Future<void> login(
    BuildContext context,
    TextEditingController usernameController,
    TextEditingController passwordController,
    Function(bool) setLoading,
    Function(String?) setErrorMessage,
  ) async {
    setLoading(true);
    setErrorMessage(null);

    final String username = usernameController.text;
    final String password = passwordController.text;
    const String BaseUrl = Api.Url;
    final response = await http.post(
      Uri.parse('$BaseUrl/login'), // Replace with your server URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    setLoading(false);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final String token = responseBody['token'];
      final int id = responseBody['id'];

      // Save token into SharedPreferences
      await saveToken(token);

      // Navigate to NavBar upon successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => NavBar(
                  token: token,
                  id: id,
                )),
      );
    } else {
      // Handle error
      setErrorMessage('Đăng nhập không thành công. Vui lòng thử lại.');
    }
  }
}
