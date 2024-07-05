class OrderDetailsUI {
  String? orderNumber;
  int? status;
  String? lastName;
  String? address1;
  String? phone;
  String? productName;
  int? imageId;
  String? unitPrice;
  int? productId;
  int? quantity;
  String? image1;

  OrderDetailsUI(
      {this.orderNumber,
      this.status,
      this.lastName,
      this.address1,
      this.phone,
      this.productName,
      this.imageId,
      this.unitPrice,
      this.productId,
      this.quantity,
      this.image1});

  OrderDetailsUI.fromJson(Map<String, dynamic> json) {
    orderNumber = json['order_number'];
    status = json['status'];
    lastName = json['last_name'];
    address1 = json['address1'];
    phone = json['phone'];
    productName = json['product_name'];
    imageId = json['image_id'];
    unitPrice = json['unit_price'];
    productId = json['product_id'];
    quantity = json['quantity'];
    image1 = json['image1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_number'] = this.orderNumber;
    data['status'] = this.status;
    data['last_name'] = this.lastName;
    data['address1'] = this.address1;
    data['phone'] = this.phone;
    data['product_name'] = this.productName;
    data['image_id'] = this.imageId;
    data['unit_price'] = this.unitPrice;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['image1'] = this.image1;
    return data;
  }
}
