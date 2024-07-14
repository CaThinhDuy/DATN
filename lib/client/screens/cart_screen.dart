import 'package:flutter/material.dart';
import '../../server/api_services.dart';
import '../../server/user_state.dart';
import '../models/order.dart';
import '../models/order_detail.dart';
import 'package:provider/provider.dart';

import '../widgets/widget_gio_hang/cart_item.dart';
import 'login_screen.dart';
import 'pay_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Order> _orders = [];
  List<Order> _filteredOrders = [];
  List<OrderDetails> _orderDetails = [];
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkUserLoginStatus();
    _loadProductData();
  }

  void _calculateTotalAmount() {
    double total = 0.0;
    for (final orderDetail in _orderDetails) {
      total += orderDetail.unitPrice * orderDetail.quantity;
      context.read<UserState>().setTotal(total);
      _filteredOrders.first.totalAmount = total;
      context.read<UserState>().setOrderId(_filteredOrders.first.id!);
    }
    // setState(() {
    //   _filteredOrders.first.totalAmount = total;
    // });
  }

  void _updateTotalAmount() async {
    try {
      final apiService = APIServices();
      await apiService.update('order', _filteredOrders.first.id,
          {'totalAmount': _filteredOrders.first.totalAmount});
      print('Gia tri: ${_filteredOrders.first.totalAmount}');
    } catch (e) {
      print(e);
    }
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      _orderDetails[index].quantity = newQuantity;
      _calculateTotalAmount();
    });
  }

  Future<void> _checkUserLoginStatus() async {
    final userState = context.read<UserState>();
    setState(() {
      isLoggedIn = userState.isUserLoggedIn;
    });
  }

  Future<void> _loadProductData() async {
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
        
        context.read<UserState>().setOrderId(1);
        _orderDetails = orderDetails
            .map((json) => OrderDetails.fromJson(json))
            .where((orderDetail) =>
                _filteredOrders.any((order) => orderDetail.orderId == order.id))
            .toList();

        _calculateTotalAmount();
      });
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  void _navigateToCheckoutPage() async {
    _updateTotalAmount();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PayScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: Center(
        child: isLoggedIn ? _buildCartContent() : _buildLoginPrompt(),
      ),
    );
  }

  Widget _buildLoginPrompt() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Đăng nhập để mua hàng!'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          child: const Text('Đăng nhập'),
        ),
      ],
    );
  }

  Widget _buildCartContent() {
    return _filteredOrders.isEmpty
        ? const Center(
            child: Text('Giỏ hàng của bạn đang trống!'),
          )
        : Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: _orderDetails.length,
                itemBuilder: (context, index) {
                  final orderDetail = _orderDetails[index];
                  return CartItem(
                    orderDetail: orderDetail,
                    onQuantityChanged: (quantity) =>
                        _updateQuantity(index, quantity),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng tiền: ${_filteredOrders.first.totalAmount.toStringAsFixed(0).replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]},',
                        )} VND',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _navigateToCheckoutPage,
                    child: const Text('Thanh toán'),
                  ),
                ],
              ),
            ),
          ]);
  }
}
