import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/screens/product_detail_screen.dart';

import 'client/widgets/nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: ProductDetailScreen(
        product: Product(
            name: 'sp001',
            imageUrl:
                'https://product.hstatic.net/200000722513/product/pc_case_xigmatek_-_26_50758d07dff4461ebd00809e2699e2e0_grande.png',
            price: 100000000,
            description:
                'CPU Intel Core i5-12400F, nhân tố khuất đảo thị trường PC Gaming khi sở hữu mức giá rẻ cùng hiệu năng xuất sắc. Với 6 nhân 12 luồng, xung nhịp 2.5GHz và turbo boost lên 4.4 GHz, quả là sự lựa chọn tuyệt vời từ khả năng chơi game cho tới stream game của thế hệ vi xử lý Intel Gen 12, chính là sự nâng cấp vượt bậc so với người tiền nhiệm i5-11400F.'),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
