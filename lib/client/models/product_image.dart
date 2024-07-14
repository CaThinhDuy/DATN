class ProductImage {
  final int id;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;

  ProductImage({
    required this.id,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      image1: json['image1'],
      image2: json['image2'],
      image3: json['image3'],
      image4: json['image4'],
      image5: json['image5'],
    );
  }
}

///Không có sửa nha Nam
