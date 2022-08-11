import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orders/orders/model.dart';

class OrdersProvider extends ChangeNotifier {
  List<Order> orders = [];

  late DateTime date;

  late StreamSubscription<List<Order>> _subscription;

  OrdersProvider() {
    var now = DateTime.now();
    date = DateTime(now.year, now.month, now.day);
    _subscription = _stream().listen(_updateOrders);
  }

  _updateOrders(List<Order> orders) {
    this.orders = orders;
    notifyListeners();
  }

  Stream<List<Order>> _stream() {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('datetime', isGreaterThanOrEqualTo: date)
        .where('datetime', isLessThan: date.add(const Duration(days: 1)))
        .snapshots()
        .map(_mapSnapshot);
  }

  List<Order> _mapSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(_orderFromDocument).toList();
  }

  Order _orderFromDocument(DocumentSnapshot doc) {
    var order = Order()
      ..id = doc.id
      ..client.id = doc.get('client')['id']
      ..client.name = doc.get('client')['name']
      ..client.phone = doc.get('client')['phone']
      ..address.description = doc.get('address')['description']
      ..address.complement = doc.get('address')['complement']
      ..payment.kind = doc.get('payment')['kind']
      ..payment.status = doc.get('payment')['status']
      ..datetime = doc.get('datetime').toDate();

    doc.get('items').forEach((key, value) {
      order.items[key] = OrderItem(key, value['description'], value['price'])
        ..quantity = value['quantity'];
    });

    return order;
  }

  void changeDate(DateTime date) async {
    this.date = date;
    await _subscription.cancel();
    _subscription = _stream().listen(_updateOrders);
    notifyListeners();
  }

  void deleteOrder(Order order) {
    FirebaseFirestore.instance.collection('orders').doc(order.id).delete().then(
        (_) => _updateOrders(orders.where((o) => o.id != order.id).toList()));
  }
}
