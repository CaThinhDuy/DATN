class Product {
  int? id;
  String? name;
  String? description;
  String? salePrice;
  String? discountPrice;
  int? categoryId;
  int? quantity;
  int? status;
  int? imageId;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.name,
      this.description,
      this.salePrice,
      this.discountPrice,
      this.categoryId,
      this.quantity,
      this.status,
      this.imageId,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    salePrice = json['sale_price'];
    discountPrice = json['discount_price'];
    categoryId = json['category_id'];
    quantity = json['quantity'];
    status = json['status'];
    imageId = json['image_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['sale_price'] = this.salePrice;
    data['discount_price'] = this.discountPrice;
    data['category_id'] = this.categoryId;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['image_id'] = this.imageId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
