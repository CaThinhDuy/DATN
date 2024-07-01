import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/ImageCarousel.dart';
import '../widgets/button_custom.dart';
import '../widgets/up_down_widget.dart';
import 'cart_screen.dart';
import 'pay_screen.dart';

// Product Detail Screen widget
class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  void _navigateToPay(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PayScreen()),
    );
  }

  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 255, 92, 52),
        title: Text(
          product.name,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _navigateToCart(context);
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 25,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: ImageCarousel()
                  // Image.network(
                  //   product.imageUrl,
                  //   fit: BoxFit.contain,
                  //   height: 200,
                  //   width: double.infinity,
                  // ),
                  ),
              const SizedBox(height: 16),
              Text(
                product.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${product.price.toStringAsFixed(2)} VNĐ',
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
              const SizedBox(height: 8),
              const UpDownWidget(),
              const SizedBox(height: 8),
              ContainerButton(
                label: 'Mua ngay ',
                onPressed: () {
                  _navigateToPay(context);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ContainerButton(
                label: 'Thêm vào giỏ hàng',
                onPressed: () {
                  _navigateToCart(context);
                },
                icon: Icons.add_shopping_cart_sharp,
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Thông tin sản phẩm',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Scrollbar(
                    interactive: true,
                    child: SingleChildScrollView(
                      child: Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomSheet: NavBar(),
    );
  }
}
