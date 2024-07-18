import 'package:flutter/material.dart';
import 'package:flutter_application_1/server/orderService.dart';
import 'package:flutter_application_1/utils/standard_UI.dart';

import '../../server/api_services.dart';

import '../models/product.dart';
import '../models/product_image.dart';
import '../widgets/widgets_trang_chu/product_list.dart';
import 'order_details_screen.dart';

class OrderScreen extends StatefulWidget {
  final int user_id;
  const OrderScreen(
      {super.key, required this.user_id}); // Constructor của Widget

  @override
  State<OrderScreen> createState() =>
      _OrderScreenState(); // Tạo state cho Widget
}

class _OrderScreenState extends State<OrderScreen> {
  List<Map<String, dynamic>> orders = []; // Danh sách đơn hàng ban đầu
  List<Map<String, dynamic>> filteredOrders = []; // Danh sách đơn hàng được lọc
  List<Product> _products = [];

  List<ProductImage> _productImages = [];

  bool isLoading = true; // Biến xác định trạng thái tải dữ liệu
  int selectedStatus =
      -1; // Trạng thái đơn hàng được chọn, -1 là không có bộ lọc
  late OrderService orderService; // Dịch vụ xử lý đơn hàng

  @override
  void initState() {
    super.initState();
    orderService = OrderService(); // Khởi tạo dịch vụ đơn hàng
    fetchOrders(); // Gọi hàm để tải danh sách đơn hàng
    _loadProductData(); // Gọi hàm để tải danh sách sản phẩm
  }

  String formatCurrency(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},',
            ) +
        ' đ';
  }

  Future<void> _loadProductData() async {
    try {
      final apiService = APIServices();
      final products = await apiService.getAll('product');
      final productImages = await apiService.getAll('product_image');

      setState(() {
        _products = products.map((json) => Product.fromJson(json)).toList();

        _productImages =
            productImages.map((json) => ProductImage.fromJson(json)).toList();
      });
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  // Hàm tải danh sách đơn hàng từ server
  Future<void> fetchOrders() async {
    try {
      final fetchedOrders = await orderService
          .fetchOrders(widget.user_id); // Gọi API để lấy danh sách đơn hàng
      setState(() {
        orders =
            mergeOrders(fetchedOrders); // Gộp các đơn hàng vào danh sách orders
        filteredOrders =
            orders; // Khởi tạo filteredOrders ban đầu là toàn bộ danh sách
        for (var order in orders) {
          order['total_amount'] = double.parse(order['total_amount']
              .split('.')[0]); // Xử lý số tiền thành kiểu int
        }
        isLoading = false; // Đã tải xong, isLoading = false
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Xử lý lỗi khi không tải được danh sách đơn hàng
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Không thể tải dữ liệu đơn hàng: $e')), // Hiển thị thông báo lỗi
      );
    }
  }

  // Hàm gộp các đơn hàng có cùng mã vào một đơn hàng duy nhất
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

    return mergedOrders.values
        .toList(); // Trả về danh sách đơn hàng đã được gộp
  }

  // Hàm lọc các đơn hàng theo trạng thái
  void filterOrders(int status) {
    setState(() {
      selectedStatus = status; // Đặt trạng thái đã chọn
      if (status == -1) {
        filteredOrders = orders; // Hiển thị tất cả đơn hàng nếu không có bộ lọc
      } else {
        filteredOrders = orders
            .where((order) => order['status'] == status)
            .toList(); // Lọc các đơn hàng theo trạng thái
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
                // Các nút lọc đơn hàng
                ElevatedButton(
                  onPressed: () => filterOrders(-1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedStatus == -1
                        ? Colors.blue
                        : Colors.grey, // Màu nền của nút
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16), // Khoảng cách nút
                  ),
                  child: const Text('Tất cả',
                      style: TextStyle(color: Colors.white)), // Nhãn nút
                ),
                const SizedBox(width: 8), // Khoảng cách giữa các nút
                // Các nút lọc khác tương tự
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
            child: isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator()) // Hiển thị tiêu đề tải nếu isLoading là true
                : filteredOrders.isEmpty
                    ? Center(
                        child: Column(
                        children: [
                          const SizedBox(
                              height: 100,
                              child: Text('Không có đơn hàng nào')),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Gợi ý sản phẩm",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                                child: ProductList(
                                    products: _products,
                                    productImages: _productImages)),
                          ),
                        ],
                      )) // Hiển thị thông báo nếu không có đơn hàng
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
                              ).then((value) {
                                fetchOrders(); // Gọi lại hàm fetchOrders để làm mới danh sách đơn hàng sau khi quay lại từ màn hình chi tiết đơn hàng
                              });
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
                                  // Danh sách sản phẩm trong đơn hàng
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
                                            formatCurrency(
                                                order["total_amount"]),
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

  // Hàm trả về văn bản trạng thái dựa trên mã trạng thái
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
        return 'Chưa xác định';
    }
  }
}
