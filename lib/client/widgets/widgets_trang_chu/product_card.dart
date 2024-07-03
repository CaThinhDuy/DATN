import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../models/product_image.dart';
import 'product_detail.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ProductImage proImg;

  const ProductCard({
    super.key,
    required this.product,
    required this.proImg,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: product,
              proImg: proImg,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                proImg.image1,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                product.name,
                style: const TextStyle(fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${product.salePrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} đ',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
