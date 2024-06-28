import 'dart:convert';
import 'package:flutter_application_1/client/models/user_db.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/utils/api.dart';

class UserService {
  static Future<user?> getUserProfile(String token, int idUser) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.Url}/user/$idUser'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return user.fromJson(data);
      } else {
        print('Failed to load user profile');
        return null;
      }
    } catch (e) {
      print('Error loading user profile: $e');
      return null;
    }
  }
}
