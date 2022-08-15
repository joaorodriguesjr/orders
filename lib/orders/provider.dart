import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orders/clients/model.dart';
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
      order.items[key] = Item.fromData(
          key, value['description'], value['price'], value['quantity']);
    });

    return order;
  }

  void changeDate(DateTime date) async {
    this.date = date;
    await _subscription.cancel();
    _subscription = _stream().listen(_updateOrders);
    notifyListeners();
  }

  Future<void> registerOrder(Order order, Client client) async {
    var data = {
      'client': {
        'id': client.id,
        'name': client.name,
        'phone': client.phone,
      },
      'address': {
        'description': client.address.description,
        'complement': client.address.complement,
      },
      'datetime': order.datetime.toUtc(),
      'items': {
        for (var item in order.items.values)
          item.product.id: {
            'description': item.product.description,
            'price': item.product.price,
            'quantity': item.quantity,
          }
      },
      'payment': {
        'kind': order.payment.kind,
        'status': order.payment.status,
      },
    };

    await FirebaseFirestore.instance.collection('orders').add(data);
  }

  void deleteOrder(Order order) {
    FirebaseFirestore.instance.collection('orders').doc(order.id).delete().then(
        (_) => _updateOrders(orders.where((o) => o.id != order.id).toList()));
  }
}
