// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/screens/trang_chu.dart';
import 'package:flutter_application_1/client/widgets/nav.dart';
// import 'package:flutter_application_1/client/models/order_detail.dart';

import '../../server/api_services.dart';
import '../../server/user_state.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../models/order_detail.dart';

// ignore: must_be_immutable
class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  List<Order> _orders = [];
  List<Order> _filteredOrders = [];
  List<OrderDetails> _orderDetails = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _datHang() async {
    try {
      final newOrder = Order(
          id: context.read<UserState>().orderId,
          userId: context.read<UserState>().userId,
          totalAmount: context.read<UserState>().total,
          status: 1);

      final apiService = APIServices();
      apiService.update('order', _filteredOrders.first.id, newOrder.toJson());
      print('Dat hang thanh cong!');
      // Hiển thị hộp thoại
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Xác nhận đặt hàng'),
          content: Text('Bạn đã đặt hàng thành công!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NavBar()),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loadData() async {
    try {
      final apiService = APIServices();
      final orders = await apiService.getAll('order');
      final orderDetails = await apiService.getAll('order_details');

      setState(() {
        _orders = orders.map((json) => Order.fromJson(json)).toList();
        _filteredOrders = _orders
            .where((order) =>
                order.status == 0 &&
                order.userId == context.read<UserState>().userId)
            .toList();

        _orderDetails = orderDetails
            .map((json) => OrderDetails.fromJson(json))
            .where((orderDetail) =>
                _filteredOrders.any((order) => orderDetail.orderId == order.id))
            .toList();
      });
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Hiện địa chỉ người dùng
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Địa chỉ nhận hàng:'),
                SizedBox(height: 8.0),
                Text('123 Đường ABC, Quận XYZ, Thành phố DEF'),
              ],
            ),
          ),

          // 3. Dòng chữ "Thanh toán khi nhận hàng"
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Thanh toán khi nhận hàng'),
          ),

          // 4. Tổng số tiền
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng tiền: ${context.read<UserState>().total.toStringAsFixed(0).replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},',
                      )} VND',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 5. Nút đặt hàng
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _datHang,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                // shape: const RectangleBorder(),
              ),
              child: const Text('Đặt hàng'),
            ),
          ),
        ],
      ),
    );
  }
}
