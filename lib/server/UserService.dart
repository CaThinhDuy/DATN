import 'dart:convert';
import 'package:flutter_application_1/client/models/user_db.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/utils/api.dart';

class UserService {
  static Future<User?> getUserProfile(String token, int idUser) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}/user/$idUser'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        print('Failed to load user profile');
        return null;
      }
    } catch (e) {
      print('Error loading user profile: $e');
      return null;
    }
  }

  static Future<User?> updateUserProfile(
      String token, int idUser, Map<String, dynamic> updatedData) async {
    try {
      final response = await http.put(
        Uri.parse('${Api.baseUrl}/user/$idUser'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedData),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        print('Failed to load user profile: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error loading user profile: $e');
      return null;
    }
  }

  static Future<bool> forgetPassWord(String email) async {
    final response = await http.post(
      Uri.parse(
          '${Api.userServiceUrl}/forget-password'), // Replace with your server URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    print(response.body);
    return (response.statusCode == 200) ? true : false;
  }

  static Future<bool> resetPassWord(String token, String newPassWord) async {
    final response = await http.post(
      Uri.parse(
          '${Api.userServiceUrl}/reset-password'), // Replace with your server URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "token": token,
        'newPassword': newPassWord,
      }),
    );
    return (response.statusCode == 200) ? true : false;
  }
}
