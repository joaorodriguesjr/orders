import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/products/model.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> products = [];

  ProductsProvider() {
    _loadProducts();
  }

  _loadProducts() async {
    var snapshot = await FirebaseFirestore.instance.collection('items').get();

    products = snapshot.docs.map((doc) {
      var data = doc.data();
      var product = Product();
      product.id = doc.id;
      product.description = data['description'];
      product.price = data['price'];
      return product;
    }).toList();

    notifyListeners();
  }
}
