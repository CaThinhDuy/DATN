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

  const OrderDetailsScreen({
    Key? key,
    required this.order_id,
    required this.TotalMoney,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;
  late OrderService orderService;
  late int status; // Biến lưu trữ trạng thái đơn hàng

  @override
  void initState() {
    super.initState();
    orderService = OrderService();
    fetchOrders(); // Gọi hàm để tải chi tiết đơn hàng khi màn hình được khởi tạo
  }

  // Hàm để tải chi tiết đơn hàng từ API
  Future<void> fetchOrders() async {
    try {
      final fetchedOrders =
          await orderService.fetchOrdersDetails(widget.order_id);

      // Nếu có dữ liệu đơn hàng trả về từ API
      if (fetchedOrders.isNotEmpty) {
        setState(() {
          orders =
              mergeOrders(fetchedOrders); // Gộp các đơn hàng có cùng số đơn
          status =
              orders.first['status']; // Lưu trạng thái của đơn hàng đầu tiên
          isLoading = false; // Đã tải dữ liệu xong
        });
      } else {
        setState(() {
          isLoading = false; // Không có đơn hàng nào
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Lỗi khi tải dữ liệu đơn hàng
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể tải dữ liệu đơn hàng: $e')),
      );
    }
  }

  // Hàm để cập nhật trạng thái đơn hàng
  Future<void> statusOrders(
      int orderID, Map<String, dynamic> updatedData) async {
    try {
      final statusOrder =
          await OrderService.updateOrderStatus(orderID, updatedData);

      // Hiển thị thông báo thành công hoặc thất bại khi cập nhật trạng thái
      if (statusOrder != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cập nhật trạng thái đơn hàng thành công')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không thể cập nhật trạng thái đơn hàng')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể tải dữ liệu đơn hàng: $e')),
      );
    }
  }

  // Hàm gộp các đơn hàng có cùng số đơn
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
          'products_image': [],
        };
      }
      // Kiểm tra xem sản phẩm đã tồn tại trong danh sách sản phẩm của mergedOrders chưa
      bool productExists = mergedOrders[orderNumber]!['products']
          .any((product) => product['product_id'] == order['product_id']);
      bool userExists = mergedOrders[orderNumber]!['users']
          .any((users) => users['phone'] == order['phone']);
      bool imageExists = mergedOrders[orderNumber]!['products_image']
          .any((image) => image['image1'] == order['image1']);

      // Nếu sản phẩm chưa tồn tại, thêm vào danh sách sản phẩm của mergedOrders
      if (!productExists) {
        mergedOrders[orderNumber]!['products'].add({
          'name': order['product_name'],
          'product_id': order['product_id'],
          'unit_price': order['unit_price'] =
              int.parse(order['total_amount'].split('.')[0]),
          'quantity': order['quantity'],
        });
      }

      // Nếu người dùng chưa tồn tại, thêm vào danh sách người dùng của mergedOrders
      if (!userExists) {
        mergedOrders[orderNumber]!['users'].add({
          'last_name': order['last_name'],
          'phone': order['phone'],
          'address1': order['address1'],
        });
      }

      // Nếu hình ảnh sản phẩm chưa tồn tại, thêm vào danh sách hình ảnh của mergedOrders
      if (!imageExists) {
        mergedOrders[orderNumber]!['products_image'].add({
          'image1': order['image1'],
        });
      }
    }
    print(mergedOrders.values.toList());
    return mergedOrders.values.toList(); // Trả về danh sách đơn hàng đã gộp
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          return Container(
                            constraints: const BoxConstraints(
                              minHeight:
                                  650, // Đặt chiều cao tối thiểu cho Container
                            ),
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(width: 2),
                              ),
                              margin: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: order["products"].length,
                                    itemBuilder: (context, productIndex) {
                                      final product =
                                          order["products"][productIndex];
                                      return ListTile(
                                        leading: Image.network(
                                          order["products_image"][productIndex]
                                              ["image1"],
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
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
                            ),
                          );
                        },
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ContainerButton(
              label: 'HỦY',
              onPressed: () {
                if (status == 1) {
                  // Kiểm tra nếu đơn hàng có trạng thái là 1 (Chưa xử lý)
                  statusOrders(widget.order_id,
                      {'status': 4}); // Cập nhật trạng thái hủy đơn hàng
                  fetchOrders();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Trạng thái đơn hàng không phù hợp để hủy')),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Hàm trả về chuỗi mô tả trạng thái dựa vào số
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
