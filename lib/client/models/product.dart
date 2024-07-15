class Product {
  final int id;
  final String name;
  final String description;
  final double salePrice;
  final double discountPrice;
  final int categoryId;
  late final int quantity;
  final int status;
  final int imageId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.salePrice,
    required this.discountPrice,
    required this.categoryId,
    required this.quantity,
    required this.status,
    required this.imageId
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      salePrice: double.parse(json['sale_price'].toString()),
      discountPrice: double.parse(json['discount_price'].toString()),
      categoryId: json['category_id'],
      quantity: json['quantity'],
      status: json['status'],
      imageId: json['imageId'],
    );
  }
}

///Không có sửa nha Nam