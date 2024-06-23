class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  Product(
      {required this.name,
      required this.imageUrl,
      required this.price,
      required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'] ?? 'Unknown',
        imageUrl: json['imageUrl'] ?? '',
        price: json['price'].toDouble() ?? 0.0,
        description: json['description'] ?? 'NO description ');
  }
}
