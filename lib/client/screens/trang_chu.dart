// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/widgets/widgets_trang_chu/category_widget.dart';
// import 'package:flutter_application_1/client/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/client/widgets/widgets_trang_chu/search_widget.dart';

import '../../server/api_services.dart';
import '../models/product.dart';
import '../models/product_image.dart';
import '../widgets/widgets_trang_chu/page_view_slider.dart';
// import '../widgets/product_cate.dart';
import '../widgets/widgets_trang_chu/product_list.dart';
// import 'cart_screen.dart';
import 'search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<ProductImage> _productImages = [];

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  Future<void> _loadProductData() async {
    try {
      final products = await APIServices.getAll('product');
      final productImages = await APIServices.getAll('product_image');

      setState(() {
        _products = products.map((json) => Product.fromJson(json)).toList();
        _filteredProducts = _products;
        _productImages =
            productImages.map((json) => ProductImage.fromJson(json)).toList();
      });
    } catch (e) {
      setState(() {
        print('Loi');
      });
    }
  }

  void _filterProductsByCategory(int categoryId) {
    setState(() {
      if (categoryId == 0) {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products
            .where((product) => product.categoryId == categoryId)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(
        onSearchTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
        },
        onCartTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => CartScreen(
          //             cart: const [],
          //             onCartUpdated: (updatedCart) {
          //               setState(() {
          //                 [] = updatedCart;
          //               });
          //             },
          //           )),
          // );
        },
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          PageViewSlider(),
          CategoryWidget(onCategorySelected: _filterProductsByCategory),
          ProductList(
            products: _filteredProducts,
            productImages: _productImages,
          ),
        ],
      )),
    );
  }
}
