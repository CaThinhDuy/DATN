import 'dart:convert';
import 'package:flutter_application_1/utils/api.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static const String baseUrl = Api.orderService;

  // Future<void> placeOrder(
  //     List<CartItem> cartItems, int userId, String totalAmount) async {
  //   final url = Uri.parse('$baseUrl/user/$userId');
  //   final orderData = {
  //     "user_id": userId,
  //     "products": cartItems.map((item) => item.toJson()).toList(),
  //     "total_amount": totalAmount,
  //   };
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {"Content-Type": "application/json"},
  //       body: json.encode(orderData),
  //     );

  //     if (response.statusCode == 200) {
  //       print('Order placed successfully');
  //     } else {
  //       print('Failed to place order: ${response.statusCode} ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

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
}