import 'package:inventory/inventory.dart';

class Record {
  String id = '';

  DateTime moment = DateTime.now();

  double price = 0.0, quantity = 0.0;

  Product product = Product();

  static Record create(Map<String, dynamic> data, Product product) {
    return Record()
      ..price = data['price']
      ..quantity = data['quantity']
      ..product = product;
  }

  static Record createExitRecord(Map<String, dynamic> data, Product product) {
    return Record()
      ..quantity = (-data['quantity'])
      ..product = product;
  }
}
