import 'package:flutter/material.dart';

import '../widgets/page_view_slider.dart';
import '../widgets/product_cate.dart';
import '../widgets/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFee4d2d),
        title: Row(
          children: [
            // Image.asset(
            //   // 'assets/logo.png',
            //   // height: 30,
            // ),
            // SizedBox(width: 20.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Tìm kiếm',
                      border: InputBorder.none,
                      prefixIcon: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFee4d2d),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const PageViewSlider(),
          ProductCategory(),
          Expanded(
            flex: 3,
            child: ProductList(),
          ),
        ],
      ),
    );
  }
}
