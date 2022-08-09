import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orders/items/model.dart';

class ItemsProvider extends ChangeNotifier {
  List<Item> items = [];

  ItemsProvider() {
    _loadItems();
  }

  _loadItems() async {
    var snapshot = await FirebaseFirestore.instance.collection('items').get();

    items = snapshot.docs.map((doc) {
      var data = doc.data();
      var item = Item();
      item.id = doc.id;
      item.description = data['description'];
      item.price = data['price'];
      return item;
    }).toList();

    notifyListeners();
  }
}
