import 'package:flutter/material.dart';
import 'package:flutter_application_1/server/orderService.dart';
import 'package:flutter_application_1/utils/standard_UI.dart';

import 'order_details_screen.dart';

class OrderScreen extends StatefulWidget {
  final int user_id;
  const OrderScreen({super.key, required this.user_id});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Map<String, dynamic>> orders = [];
  List<Map<String, dynamic>> filteredOrders = [];
  bool isLoading = true;
  int selectedStatus = -1; // -1 indicates no filter
  late OrderService orderService;

  @override
  void initState() {
    super.initState();
    orderService = OrderService();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final fetchedOrders = await orderService.fetchOrders(widget.user_id);
      setState(() {
        orders = mergeOrders(fetchedOrders);
        filteredOrders = orders; // Initialize with all orders
        for (var order in orders) {
          order['total_amount'] =
              int.parse(order['total_amount'].split('.')[0]);
        }
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
          'status': order['status'],
          'id': order['id'],
          'total_amount': order['total_amount'],
          'products': []
        };
      }
      mergedOrders[orderNumber]!['products'].add({
        'name': order['name'],
        'quantity': order['quantity'],
        'product_id': order['product_id'],
      });
    }

    return mergedOrders.values.toList();
  }

  void filterOrders(int status) {
    setState(() {
      selectedStatus = status;
      if (status == -1) {
        filteredOrders = orders;
      } else {
        filteredOrders =
            orders.where((order) => order['status'] == status).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đơn hàng',
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => filterOrders(-1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedStatus == -1 ? Colors.blue : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('Tất cả',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => filterOrders(1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedStatus == 1 ? Colors.blue : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('Chưa xử lý',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => filterOrders(2),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedStatus == 2 ? Colors.blue : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('Đang vận chuyển',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => filterOrders(3),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedStatus == 3 ? Colors.blue : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('Đã giao thành công',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => filterOrders(4),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedStatus == 4 ? Colors.blue : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('Đã hủy',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            // Added Expanded widget here
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredOrders.isEmpty
                    ? const Center(child: Text('Không có đơn hàng nào'))
                    : ListView.builder(
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailsScreen(
                                    order_id: order["id"],
                                    TotalMoney: order["total_amount"],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(width: 2),
                              ),
                              margin: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              top: BorderSide(width: 1))),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Tổng số tiền: ',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            '${order["total_amount"]}',
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
                            ),
                          );
                        },
                      ),
          ),
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
