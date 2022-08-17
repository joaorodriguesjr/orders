class Product {
  String id = '';
  String description = '';
  int price = 0;

  Product();

  factory Product.fromData(String id, String description, int price) {
    var product = Product()
      ..id = id
      ..description = description
      ..price = price;

    return product;
  }
}
