import 'package:flutter/material.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<PayScreen> {
  // Khai báo các biến state cần thiết
  String shippingAddress = '123 Đường ABC, Quận XYZ, Thành Phố...';
  List<CartItem> cartItems = [
    CartItem(name: 'Món A', quantity: 2),
    CartItem(name: 'Món B', quantity: 1),
  ];
  double totalAmount = 150000.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh Toán'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Địa Chỉ Nhận Hàng:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(shippingAddress),
            const SizedBox(height: 16),
            const Text(
              'Đơn Hàng:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cartItems[index].name),
                      Text('x${cartItems[index].quantity}'),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tổng Số Tiền: $totalAmount',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện khi nhấn nút đặt hàng
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Đặt Hàng',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final String name;
  final int quantity;

  CartItem({required this.name, required this.quantity});
}
