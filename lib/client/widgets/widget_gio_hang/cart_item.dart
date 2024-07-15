import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/models/order_detail.dart';

import '../../../server/api_services.dart';
import '../../models/product.dart';
import '../../models/product_image.dart';

// ignore: must_be_immutable
class CartItem extends StatefulWidget {
  OrderDetails orderDetail;
  final void Function(int quantity) onQuantityChanged;
  CartItem({
    super.key,
    required this.orderDetail,
    required this.onQuantityChanged,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late Product _product;
  List<ProductImage> _productImages = [];
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _loadProductData();
    _quantity = widget.orderDetail.quantity;
  }

  void _updateQuantity(int newQuantity) async {
    setState(() {
      _quantity = newQuantity;
    });
    widget.onQuantityChanged(_quantity);

    // Kiểm tra xem quantity có nhỏ hơn 1 không
    if (_quantity < 1) {
      // Xóa order_details
      try {
        final apiService = APIServices();
        await apiService.delete('order_details', widget.orderDetail.id!);
        print("Xoa thanh cong order_details");
      } catch (e) {
        print('Lỗi khi xóa order_details: $e');
      }
    } else {
      // Cập nhật quantity trên server
      try {
        final apiService = APIServices();
        await apiService.update(
            'order_details', widget.orderDetail.id, {'quantity': _quantity});
      } catch (e) {
        print('Lỗi khi cập nhật quantity: $e');
      }
    }
  }

  void _incrementQuantity() {
    _updateQuantity(_quantity + 1);
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      _updateQuantity(_quantity - 1);
    } else {
      _updateQuantity(0);
    }
  }

  Future<void> _loadProductData() async {
    try {
      final apiService = APIServices();
      final product =
          await apiService.getById('product', widget.orderDetail.productId);
      final productImages = await apiService.getAll('product_image');

      setState(() {
        _product = Product.fromJson(product);
        _productImages =
            productImages.map((json) => ProductImage.fromJson(json)).toList();
      });
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  List<ProductImage> _getMatchingProductImages() {
    return _productImages.where((pi) => pi.id == _product.imageId).toList();
  }

  double get totalPrice {
    return _product.salePrice * widget.orderDetail.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final unitPrice = _product.salePrice;
    final totalPrice = unitPrice * _quantity;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          if (_getMatchingProductImages().isNotEmpty)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_getMatchingProductImages().first.image1),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${totalPrice.toStringAsFixed(0).replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},',
                      )}  đ',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _updateQuantity(
                        _quantity > 1 ? _quantity - 1 : 1,
                      ),
                    ),
                    Text(
                      widget.orderDetail.quantity.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _updateQuantity(_quantity + 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
