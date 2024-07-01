import 'package:flutter/material.dart';
import '../widgets/Search_Widget.dart';
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
        backgroundColor: const Color.fromARGB(255, 255, 92, 52),
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
                  child: const SearchWidget()),
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          PageViewSlider(),
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
