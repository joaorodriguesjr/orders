import 'package:flutter/material.dart';
import 'package:delivery/products.dart';

class ProductsController extends ChangeNotifier {
  List<Product> products = [];

  ProductsDataSource dataSource;

  ProductsController(this.dataSource) {
    dataSource.all().listen(_updateProducts);
  }

  _updateProducts(products) {
    this.products = products;
    notifyListeners();
  }
}
