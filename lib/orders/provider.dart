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
      ..client.id = doc.get('client')['id']
      ..client.name = doc.get('client')['name']
      ..address.description = doc.get('address')['description']
      ..address.complement = doc.get('address')['complement']
      ..payment.kind = doc.get('payment')['kind']
      ..payment.status = doc.get('payment')['status'];

    doc.get('items').forEach((key, value) {
      order.items[key] = OrderItem(key, value['description'], value['price'])
        ..quantity = value['quantity'];
    });

    return order;
  }

  void deleteOrder(Order order) {
    FirebaseFirestore.instance.collection('orders').doc(order.id).delete().then(
        (_) => _updateOrders(orders.where((o) => o.id != order.id).toList()));
  }
}
