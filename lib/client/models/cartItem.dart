class CartItem {
  String? orderNumber;
  int? status;
  int? id;
  String? totalAmount;
  int? productId;
  int? quantity;
  String? name;

  CartItem(
      {this.orderNumber,
      this.status,
      this.totalAmount,
      this.productId,
      this.quantity,
      this.name});

  CartItem.fromJson(Map<String, dynamic> json) {
    orderNumber = json['order_number'];
    status = json['status'];
    id = json['id'];
    totalAmount = json['total_amount'];
    productId = json['product_id'];
    quantity = json['quantity'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_number'] = orderNumber;
    data['status'] = status;
    data['id'] = id;
    data['total_amount'] = totalAmount;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['name'] = name;
    return data;
  }
}
