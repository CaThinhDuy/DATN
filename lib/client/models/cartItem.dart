class CartItem {
  String? orderNumber;
  int? status;
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
    totalAmount = json['total_amount'];
    productId = json['product_id'];
    quantity = json['quantity'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_number'] = this.orderNumber;
    data['status'] = this.status;
    data['total_amount'] = this.totalAmount;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    return data;
  }
}
