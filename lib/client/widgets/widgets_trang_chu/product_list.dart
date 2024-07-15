import 'package:flutter/material.dart';
// import '../../../server/api_services.dart';
import '../../models/product.dart';
import '../../models/product_image.dart';
// import 'category_widget.dart';
import 'product_card.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  final List<ProductImage> productImages;

  const ProductList({
    super.key,
    required this.products,
    required this.productImages,
  });
  //update new model product and product image
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        Product product = products[index];
        ProductImage? proImg = productImages.firstWhere(
          (image) => image.id == product.imageId,
        );

        return ProductCard(
          product: product,
          proImg: proImg,
        );
      },
    );
  }
}
