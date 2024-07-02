class orderDetails {
  int? id;
  int? orderId;
  int? productId;
  int? quantity;
  String? unitPrice;
  String? createdAt;
  String? updatedAt;
  int? status;

  orderDetails(
      {this.id,
      this.orderId,
      this.productId,
      this.quantity,
      this.unitPrice,
      this.createdAt,
      this.updatedAt,
      this.status});

  orderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
