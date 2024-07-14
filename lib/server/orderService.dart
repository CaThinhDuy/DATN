import 'dart:convert';
import 'package:flutter_application_1/client/models/order_db.dart';
import 'package:flutter_application_1/utils/api.dart';
import '../client/models/cartItem.dart';
import 'package:http/http.dart' as http;

import '../client/models/order_detailUI.dart';

class OrderService {
  static const String baseUrl = Api.orderService;

  Future<void> placeOrder(
      List<CartItem> cartItems, int userId, String totalAmount) async {
    final url = Uri.parse('$baseUrl/user/$userId');
    final orderData = {
      "user_id": userId,
      "products": cartItems.map((item) => item.toJson()).toList(),
      "total_amount": totalAmount,
    };
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(orderData),
      );

      if (response.statusCode == 200) {
        print('Order placed successfully');
      } else {
        print('Failed to place order: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchOrders(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/$userId'),
    );
    print('$baseUrl/user/$userId');
    print(response.body);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception(
          'Không thể tải dữ liệu đơn hàng: ${response.statusCode} ${response.body}');
    }
  }

  static const String baseOrderDetailsUrl = Api.orderDetailsService;

  Future<List<Map<String, dynamic>>> fetchOrdersDetails(int orderID) async {
    final response =
        await http.get(Uri.parse('$baseOrderDetailsUrl/order_id=$orderID'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception(
          'Không thể tải dữ liệu đơn hàng: ${response.statusCode} ${response.body}');
    }
  }

  static Future<Order?> updateOrder(
      String token, int orderID, Map<String, dynamic> updatedData) async {
    try {
      final response = await http.put(
        Uri.parse('${baseOrderDetailsUrl}/status/$orderID'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedData),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Order.fromJson(data);
      } else {
        print('Failed to load Order: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error loading  Order: $e');
      return null;
    }
  }
}
