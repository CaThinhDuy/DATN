import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/models/order_detail.dart';
import 'package:flutter_application_1/client/models/product_image.dart';
import '../../../server/api_services.dart';
import '../../../server/user_state.dart';
import '../../models/order.dart';
import '../../models/product.dart';
// import '../../screens/cart_provider.dart';
// import '../../screens/cart_screen.dart';
import '../../screens/cart_screen.dart';
import '../../screens/pay_screen.dart';
import '../imge_product_detail.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final ProductImage proImg;

  const ProductDetailPage(
      {super.key, required this.product, required this.proImg});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  

  Future<void> addToCart() async {
    try {
      final newOrderDetails = OrderDetails(
        id: null,
        orderId: context.read<UserState>().orderId,
        productId: widget.product.id,
        quantity: 1,
        unitPrice: widget.product.salePrice,
        status: 0,
      );
      if (context.read<UserState>().userId == -1) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content:
                const Text('Bạn phải đăng nhập để thêm sản phẩm vào giỏ hàng.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Đóng'),
              ),
            ],
          ),
        );
      } else {
        await APIServices().create('order_details', newOrderDetails.toMap());
      }

      // Hiển thị thông báo hoặc cập nhật giỏ hàng
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sản phẩm đã được thêm vào giỏ hàng'),
        ),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi khi thêm sản phẩm vào giỏ hàng: $e'),
        ),
      );
    }
  }

  void _buyNow() {
    print('Buying ${widget.product.name}');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PayScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartScreen()));
            },
          ),
        ],
      ),
      body: ProductDetailBody(
        product: widget.product,
        proImg: widget.proImg,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: addToCart,
                child: const Text('Thêm vào giỏ hàng'),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: ElevatedButton(
                onPressed: _buyNow,
                child: const Text('Mua ngay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailBody extends StatelessWidget {
  final Product product;
  final ProductImage proImg;

  const ProductDetailBody({
    super.key,
    required this.product,
    required this.proImg,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSlider(proImg: proImg),
            const SizedBox(height: 16.0),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              '${double.tryParse(product.salePrice.toString())?.toStringAsFixed(0).replaceAllMapped(
                    //update new product
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]},',
                  ) ?? '0'} đ',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Thông tin sản phẩm',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
