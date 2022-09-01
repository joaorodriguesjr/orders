class Product {
  String code = '', name = '', description = '';

  static Product restore(String code, Map<String, dynamic> data) {
    return Product()
      ..code = code
      ..name = data['name']
      ..description = data['description'];
  }
}