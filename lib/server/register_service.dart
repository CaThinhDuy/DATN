// lib/services/register_service.dart
import 'dart:convert';
import 'package:flutter_application_1/utils/api.dart';
import 'package:http/http.dart' as http;

const String BaseUrl = Api.Url;

class RegisterService {
  static Future<bool> register(
      String username, String password, String email) async {
    final response = await http.post(
      Uri.parse('$BaseUrl/register'), // Replace with your server URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'email': email,
      }),
    );

    return (response.statusCode == 201) ? true : false;
  }
}
