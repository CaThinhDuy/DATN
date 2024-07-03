// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/client/screens/trang_chu.dart';
// import '../models/product.dart';

// class CartScreen extends StatefulWidget {
  // final List<Product> cart;
  // final Function(List<Product>) onCartUpdated;

  // const CartScreen(
  //     {super.key, required this.cart, required this.onCartUpdated});

  // @override
  // _CartScreenState createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
  // List<CartItem> _cart = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _cart = widget.cart
  //       .map((product) => CartItem(product: product, quantity: 1))
  //       .toList();
  // }

  // void _incrementQuantity(CartItem cartItem) {
  //   setState(() {
  //     cartItem.quantity++;
  //   });
  // }

  // void _decrementQuantity(CartItem cartItem) {
  //   setState(() {
  //     if (cartItem.quantity > 1) {
  //       cartItem.quantity--;
  //     }
  //   });
  // }

  // void _removeFromCart(CartItem cartItem) {
  //   setState(() {
  //     _cart.remove(cartItem);
  //   });
  //   widget.onCartUpdated(_cart.map((item) => item.product).toList());
  // }

  // double _calculateTotalPrice() {
  //   double totalPrice = 0;
  //   for (var item in _cart) {
  //     totalPrice += item.product.salePrice * item.quantity;
  //   }
  //   return totalPrice;
  // }

  // @override
  // Widget build(BuildContext context) {
  //   var length=0;
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Color.fromARGB(255, 239, 100, 25),
    //     title: const Text(
    //       'Giỏ hàng',
    //       style: TextStyle(
    //         color: Colors.white,
    //       ),
    //     ),
    //     iconTheme: const IconThemeData(
    //       color: Colors.white,
    //     ),
    //   ),
    //   body: _cart.isEmpty
    //       ? Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               const Text(
    //                 'Giỏ hàng của bạn đang trống!',
    //                 style: TextStyle(
    //                   fontSize: 18.0,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //               const SizedBox(height: 16.0),
    //               ElevatedButton(
    //                 onPressed: () {
    //                   Navigator.pushReplacement(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => const HomePage()),
    //                   );
    //                 },
    //                 child: const Text('Mua sắm'),
    //               ),
    //             ],
    //           ),
    //         )
    //       : Column(
    //           children: [
    //             Expanded(
    //               child: ListView.builder(
    //                 itemCount: _cart.length,
    //                 itemBuilder: (context, index) {
    //                   // final cartItem = _cart[index];
    //                   return Container(
    //                     margin: const EdgeInsets.all(10),
    //                     decoration: BoxDecoration(
    //                       color: const Color.fromRGBO(245, 245, 245, 1),
    //                       borderRadius: BorderRadius.circular(8.0),
    //                     ),
    //                     child: ListTile(
    //                       // leading: Image.network(cartItem.product.imageUrl, width: 50, height: 50),
    //                       title: Text(cartItem.product.name),
    //                       subtitle: Row(
    //                         children: [
    //                           Text(
    //                             '${(cartItem.quantity * cartItem.product.salePrice).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} đ',
    //                             style: const TextStyle(
    //                               color: Colors.red,
    //                               fontWeight: FontWeight.bold,
    //                             ),
    //                           ),
    //                           const SizedBox(width: 16),
    //                           Container(
    //                             padding: const EdgeInsets.all(4.0),
    //                             decoration: BoxDecoration(
    //                               color: Colors.grey[200],
    //                               borderRadius: BorderRadius.circular(4.0),
    //                             ),
    //                             child: Row(
    //                               mainAxisSize: MainAxisSize.min,
    //                               children: [
    //                                 IconButton(
    //                                   icon: const Icon(Icons.remove,
    //                                       color: Colors.blue),
    //                                   onPressed: () =>
    //                                       _decrementQuantity(cartItem),
    //                                   padding: EdgeInsets.zero,
    //                                 ),
    //                                 Text('${cartItem.quantity}',
    //                                     style: const TextStyle(fontSize: 16.0)),
    //                                 IconButton(
    //                                   icon: const Icon(Icons.add,
    //                                       color: Colors.red),
    //                                   onPressed: () =>
    //                                       // _incrementQuantity(cartItem),
    //                                   padding: EdgeInsets.zero,
    //                                 ),
    //                               ],
    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                       trailing: IconButton(
    //                         icon: const Icon(Icons.close),
    //                         // onPressed: () => _removeFromCart(cartItem),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //             Wrap(
    //                 alignment: WrapAlignment.spaceBetween,
    //                 crossAxisAlignment: WrapCrossAlignment.center,
    //                 children: [
    //                   Row(
    //                     children: [
    //                       Expanded(
    //                         child: Column(
    //                           children: [
    //                             const Text(
    //                               'Tổng thanh toán: ',
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                             Text(
    //                               '${_calculateTotalPrice().toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} đ',
    //                               style: const TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.red),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       GestureDetector(
    //                         onTap: () {
    //                           // Thực hiện thanh toán
    //                         },
    //                         child: Container(
    //                           padding: const EdgeInsets.symmetric(
    //                               horizontal: 24.0, vertical: 16.0),
    //                           decoration: BoxDecoration(
    //                             color: const Color.fromRGBO(
    //                                 210, 5, 4, 1), // Màu đỏ
    //                             borderRadius: BorderRadius.circular(
    //                                 0), // Không có viền bo góc
    //                           ),
    //                           child: const Text(
    //                             'Thanh toán',
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 16.0, // Kích thước chữ lớn hơn
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ]),
    //           ],
    //         ),
    // );
//   }
// }

// class _cart {
// }
