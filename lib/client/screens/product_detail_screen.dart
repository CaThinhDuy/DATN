import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/widgets/Search_Widget.dart';
import 'package:flutter_application_1/client/widgets/button_custom.dart';
import 'package:flutter_application_1/client/widgets/up_down_widget.dart';
import '../models/product.dart';

// Product Detail Screen widget
class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 255, 92, 52),
        title: Text(
          product.name,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w100),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                  height: 200,
                  width: double.infinity,
                ),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerButton(
                    label: 'Mua ngay',
                    onPressed: () {
                      //xu ly chuyen trang thanh toan
                    },
                    icon: Icons.attach_money_outlined,
                  ),
                  ContainerButton(
                    label: 'Thêm vào giỏ',
                    onPressed: () {
                      //xu ly chuyen trang gio hang
                    },
                    icon: Icons.add_shopping_cart_sharp,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
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
