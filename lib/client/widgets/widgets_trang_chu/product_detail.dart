import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/models/product_image.dart';
import '../../models/product.dart';
// import '../../screens/cart_provider.dart';
// import '../../screens/cart_screen.dart';
import '../../screens/pay_screen.dart';
import '../imge_product_detail.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final ProductImage proImg;

  const ProductDetailPage(
      {super.key, required this.product, required this.proImg});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<Product> cart = [];

  void _addToCart() {
    cart.add(widget.product);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => CartScreen(
    //             cart: cart,
    //             onCartUpdated: (updatedCart) {
    //               setState(() {
    //                 cart = updatedCart;
    //               });
    //             },
    //           )),
    // );
  }

  void _buyNow() {
    // Xử lý sự kiện khi người dùng nhấn "Mua ngay"
    print('Buying ${widget.product.name}');

    // Chuyển hướng đến trang thanh toán
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
              // Xử lý sự kiện nhấn vào giỏ hàng
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
                onPressed: (){
                },
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
              '${product.salePrice.toStringAsFixed(0)
              .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} đ',
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
