import 'package:flutter/material.dart';

import '../../server/api_services.dart';

import '../models/product.dart';
import '../models/product_image.dart';
import '../widgets/widgets_trang_chu/product_detail.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchScreen> {
  List<Product> _products = [];
  List<ProductImage> _productImages = [];
  final TextEditingController _searchController = TextEditingController();
//update new model Product and product image
  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  Future<void> _loadProductData() async {
    try {
      final apiService = APIServices();
      final products = await apiService.getAll('product');
      final productImages = await apiService.getAll('product_image');

      setState(() {
        _products = products.map((json) => Product.fromJson(json)).toList();
        _productImages = productImages
            .map((json) => ProductImage.fromJson(json))
            .where((productImage) =>
                _products.any((product) => product.imageId == productImage.id))
            .toList();
      });
    } catch (e) {
      setState(() {
        print('Error');
      });
    }
  }

  List<Product> _filterProducts(String query) {
    return _products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Tìm kiếm',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() {});
              },
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_searchController.text.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _filterProducts(_searchController.text).length,
                itemBuilder: (context, index) {
                  final product =
                      _filterProducts(_searchController.text)[index];
                  final proImg = _productImages[index];
                  return ListTile(
                    title: Text(product.name),
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
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
