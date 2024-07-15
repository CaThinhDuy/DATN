class Order {
  final int? id;
  final int? userId;
  double _totalAmount = 0;
  int? status;

  Order({
    required this.id,
    required this.userId,
    required double totalAmount,
    required this.status,
  }) : _totalAmount = totalAmount;

  double get totalAmount => _totalAmount;

  set totalAmount(double value) {
    _totalAmount = value;
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        userId: json['user_id'],
        totalAmount: double.parse(json['total_amount'].toString()),
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'total_amount': totalAmount,
      'status': status,
    };
  }
}

///Không có sửa nha Nam
