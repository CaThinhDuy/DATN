import 'package:flutter/material.dart';
import 'package:flutter_application_1/client/models/user_db.dart';
import 'package:flutter_application_1/client/widgets/button_custom.dart';
import 'package:flutter_application_1/client/widgets/row_custom.dart';
import 'package:flutter_application_1/server/orderService.dart';
import 'package:flutter_application_1/utils/standard_UI.dart';

import '../models/order_db.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int order_id;
  final int TotalMoney;
  const OrderDetailsScreen(
      {Key? key, required this.order_id, required this.TotalMoney})
      : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;
  late OrderService orderService;

  @override
  void initState() {
    super.initState();
    orderService = OrderService();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final fetchedOrders =
          await orderService.fetchOrdersDetails(widget.order_id);
      setState(() {
        orders = mergeOrders(fetchedOrders);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể tải dữ liệu đơn hàng: $e')),
      );
    }
  }

  List<Map<String, dynamic>> mergeOrders(List<Map<String, dynamic>> orders) {
    Map<String, Map<String, dynamic>> mergedOrders = {};

    for (var order in orders) {
      String orderNumber = order['order_number'];
      if (!mergedOrders.containsKey(orderNumber)) {
        mergedOrders[orderNumber] = {
          'order_number': order['order_number'],
          'users': [],
          'status': order['status'],
          'products': [],
        };
      }
      // Check if the product is already in products list of mergedOrders
      bool productExists = mergedOrders[orderNumber]!['products']
          .any((product) => product['product_id'] == order['product_id']);
      bool userExists = mergedOrders[orderNumber]!['users']
          .any((users) => users['phone'] == order['phone']);

      if (!productExists) {
        mergedOrders[orderNumber]!['products'].add({
          'name': order['product_name'],
          'product_id': order['product_id'],
          'unit_price': order['unit_price'],
          'quantity': order['quantity'],
        });
      }

      if (!userExists) {
        mergedOrders[orderNumber]!['users'].add({
          'last_name': order['last_name'],
          'phone': order['phone'],
          'address1': order['address1'],
        });
      }
    }
    print(mergedOrders.values.toList());
    return mergedOrders.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết đơn hàng',
          style: TextStyle(
            fontSize: UI.wordTileSize,
            color: UI.wordTile,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: UI.backgroundApp,
        iconTheme: const IconThemeData(color: UI.wordTile),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : orders.isEmpty
                    ? const Center(child: Text('Không có đơn hàng nào'))
                    : ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(width: 2),
                            ),
                            margin: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      RowCustom(
                                        icon: Icons.person_rounded,
                                        lable: order["users"][0]["last_name"],
                                      ),
                                      RowCustom(
                                        icon: Icons.home_work_rounded,
                                        lable: order["users"][0]["address1"],
                                      ),
                                      RowCustom(
                                        icon: Icons.phone_in_talk,
                                        lable: order["users"][0]["phone"],
                                      ),
                                    ],
                                  ),
                                ),
                                ListTile(
                                  title: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(width: 1))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Đơn hàng: ${order["order_number"]}'),
                                        Row(
                                          children: [
                                            const Text(
                                              'Trạng thái:',
                                            ),
                                            Text(
                                              getStatusText(order["status"]),
                                              style: const TextStyle(
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: order["products"].length,
                                  itemBuilder: (context, productIndex) {
                                    final product =
                                        order["products"][productIndex];
                                    return ListTile(
                                      title: Text('${product["name"]}'),
                                      subtitle: Text(
                                        'Số lượng: ${product["quantity"]}',
                                        textAlign: TextAlign.end,
                                      ),
                                      trailing: Text(product["unit_price"]),
                                    );
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border:
                                            Border(top: BorderSide(width: 1))),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Tổng số tiền: ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          '${widget.TotalMoney}',
                                          style: const TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
          ),
          // ContainerButton(label: 'HỦY', onPressed: onPressed)
        ],
      ),
    );
  }

  String getStatusText(int status) {
    switch (status) {
      case 1:
        return 'Chưa xử lý';
      case 2:
        return 'Đã xử lý và đang vận chuyển';
      case 3:
        return 'Đã giao thành công';
      case 4:
        return 'Đã hủy';
      default:
        return 'Chưa đặt hàng';
    }
  }
}
