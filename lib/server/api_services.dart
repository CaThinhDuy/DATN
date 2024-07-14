import 'dart:convert';
import 'package:flutter_application_1/utils/api.dart';
import 'package:http/http.dart' as http;

class APIServices {
  // data synchronization API
  static const _baseUrl = Api.baseUrl;

  Future<List<dynamic>> getAll(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('${endpoint}: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data from $endpoint');
    }
  }

  Future<dynamic> getById(String endpoint, int id) async {
    final url = Uri.parse('$_baseUrl/$endpoint/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data from $endpoint/$id');
    }
  }

  Future<dynamic> create(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
  }

  Future<dynamic> update(
      String endpoint, int? id, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/$endpoint/$id');
    final response = await http.put(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update data in $endpoint/$id');
    }
  }

  Future<void> delete(String endpoint, int id) async {
    final url = Uri.parse('$_baseUrl/$endpoint/$id');
    final response = await http.delete(url);
    if (response.statusCode != 204) {
      throw Exception('Failed to delete data in $endpoint/$id');
    }
  }
}
