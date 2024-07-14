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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['sale_price'] = salePrice;
    data['discount_price'] = discountPrice;
    data['category_id'] = categoryId;
    data['quantity'] = quantity;
    data['status'] = status;
    data['image_id'] = imageId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
