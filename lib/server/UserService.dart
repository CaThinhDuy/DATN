import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/models/notification.dart';
import 'package:flutter_application_1/client/models/user_db.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_application_1/utils/api.dart';

import '../client/screens/login_screen.dart';
import '../client/widgets/nav.dart';

const String BaseUrl = Api.userServiceUrl;

class UserService {
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
      print(response.body);
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
    } else if (response.statusCode == 401) {
      // Xử lý lỗi xác thực
      setErrorMessage('Tên người dùng hoặc mật khẩu không đúng.');
    } else if (response.statusCode == 500) {
      // Xử lý lỗi từ phía máy chủ
      setErrorMessage('Lỗi máy chủ, vui lòng thử lại sau.');
    } else {
      // Xử lý các trường hợp lỗi khác
      setErrorMessage('Đăng nhập không thành công. Vui lòng thử lại.');
    }
  }

  static Future<void> register(
    BuildContext context,
    TextEditingController usernameController,
    TextEditingController passwordController,
    TextEditingController emailController,
    Function(bool) setLoading,
    Function(String?) setErrorMessage,
  ) async {
    setLoading(true);
    setErrorMessage(null);

    final String username = usernameController.text;
    final String password = passwordController.text;
    final String email = emailController.text;

    try {
      final response = await http.post(
        Uri.parse('$BaseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
          'email': email,
        }),
      );

      setLoading(false);

      if (response.statusCode == 201) {
        // Đăng ký thành công
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavBar()),
        );
      } else if (response.statusCode == 400) {
        // Xử lý lỗi từ phía máy chủ (ví dụ: dữ liệu không hợp lệ)
        setErrorMessage('Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.');
      } else if (response.statusCode == 409) {
        // Xử lý lỗi từ phía máy chủ (ví dụ: tài khoản đã tồn tại)
        setErrorMessage('Tài khoản đã tồn tại. Vui lòng thử lại.');
      } else {
        // Xử lý các trường hợp lỗi khác
        setErrorMessage('Đăng ký không thành công. Vui lòng thử lại.');
      }
    } catch (e) {
      setLoading(false);
      // Xử lý lỗi kết nối mạng
      setErrorMessage('Lỗi kết nối mạng. Vui lòng kiểm tra kết nối của bạn.');
    }
  }

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

  static Future<List<Map<String, dynamic>>?> getNotification(
      String token, int idUser) async {
    try {
      final response = await http.get(
        Uri.parse('${Api.notificationService}/user/$idUser'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        print('Failed to load notification: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error loading notification: $e');
      return null;
    }
  }
}
