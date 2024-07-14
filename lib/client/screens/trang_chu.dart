import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/widgets/widgets_trang_chu/category_widget.dart';
import 'package:flutter_application_1/client/widgets/widgets_trang_chu/search_widget.dart';
import '../../server/api_services.dart';
import '../../server/user_state.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/product_image.dart';
// import '../widgets/search_widget.dart';
import '../widgets/widgets_trang_chu/page_view_slider.dart';
import '../widgets/widgets_trang_chu/product_list.dart';
import 'cart_screen.dart';
import 'search_screen.dart';
import 'package:provider/provider.dart';



class HomePage extends StatefulWidget {

  const HomePage({super.key});
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<ProductImage> _productImages = [];

//update new model product and product Image
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
        _filteredProducts = _products;
        _productImages =
            productImages.map((json) => ProductImage.fromJson(json)).toList();
      });
    } catch (e) {
      print('Lỗi: $e');
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
      appBar: CustomAppBar(onSearchTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchScreen()));
      }, onCartTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CartScreen()));
      }),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const PageViewSlider(),
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
