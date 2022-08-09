import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orders/orders/model.dart';

class OrdersProvider extends ChangeNotifier {
  List<Order> orders = [];

  OrdersProvider() {
    _stream().listen(_updateOrders);
  }

  _updateOrders(List<Order> orders) {
    this.orders = orders;
    notifyListeners();
  }

  Stream<List<Order>> _stream() {
    return FirebaseFirestore.instance
        .collection('orders')
        .snapshots()
        .map(_mapSnapshot);
  }

  List<Order> _mapSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(_orderFromDocument).toList();
  }

  Order _orderFromDocument(DocumentSnapshot doc) {
    var order = Order()
      ..id = doc.id
      ..client = doc.get('client')
      ..address = doc.get('address');

    for (var item in doc.get('items')) {
      order.items[item['id']] =
          OrderItem(item['id'], item['description'], item['price']);
    }

    return order;
  }
}
