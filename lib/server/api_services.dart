import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class APIServices {
  static const _baseUrl = 'http://localhost:3000';

  static Future<List<dynamic>> getAll(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Lỗi khi gọi API GET: ${response.statusCode}');
    }
  }

  static Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Lỗi khi gọi API GET: ${response.statusCode}');
    }
  }

  ////////////
  static Future<dynamic> getById(String endpoint, String id) async {
  final url = Uri.parse('$_baseUrl/$endpoint/$id');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Lỗi khi gọi API GET: ${response.statusCode}');
  }
}
  ///////////

  static Future<dynamic> post(String endpoint, dynamic data) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Lỗi khi gọi API POST: ${response.statusCode}');
    }
  }

  static Future<dynamic> put(String endpoint, dynamic data) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.put(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Lỗi khi gọi API PUT: ${response.statusCode}');
    }
  }

  static Future<void> delete(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.delete(url);
    if (response.statusCode != 204) {
      throw Exception('Lỗi khi gọi API DELETE: ${response.statusCode}');
    }
  }
}