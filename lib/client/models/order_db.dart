class Order {
  int? id;
  int? userId;
  String? orderNumber;
  String? totalAmount;
  int? status;
  String? createdAt;
  String? updatedAt;

  Order(
      {this.id,
      this.userId,
      this.orderNumber,
      this.totalAmount,
      this.status,
      this.createdAt,
      this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderNumber = json['order_number'];
    totalAmount = json['total_amount'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_number'] = this.orderNumber;
    data['total_amount'] = this.totalAmount;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
