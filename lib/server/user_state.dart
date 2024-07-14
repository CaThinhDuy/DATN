import 'package:flutter/foundation.dart';

class UserState extends ChangeNotifier {
  int _userId = -1;
  double _total = 0.0;
  int _orderId = 0;

  double get total => _total;

  int get userId => _userId;

  int get orderId => _orderId;

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }

  void setTotal(double total) {
    _total = total;
    notifyListeners();
  }

  void setOrderId(int orderId) {
    _orderId = orderId;
    notifyListeners();
  }

  bool get isUserLoggedIn => _userId != -1;
}
