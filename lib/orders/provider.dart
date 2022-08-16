import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:delivery/clients/model.dart';
import 'package:delivery/orders/model.dart';

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
    var data = doc.data() as Map<String, dynamic>;
    var order = Order()
      ..id = doc.id
      ..client.id = data['client']['id']
      ..client.name = data['client']['name']
      ..client.phone = data['client']['phone']
      ..address.description = data['address']['description']
      ..address.complement = data['address']['complement']
      ..payment.kind = data['payment']['kind']
      ..payment.status = data['payment']['status']
      ..datetime = data['datetime'].toDate();

    data['items'].forEach((key, value) {
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

  Future<void> updateOrder(Order order) async {
    var data = {
      'client': {
        'id': order.client.id,
        'name': order.client.name,
        'phone': order.client.phone,
      },
      'address': {
        'description': order.address.description,
        'complement': order.address.complement,
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

    await FirebaseFirestore.instance
        .collection('orders')
        .doc(order.id)
        .set(data);
  }

  void deleteOrder(Order order) {
    FirebaseFirestore.instance.collection('orders').doc(order.id).delete().then(
        (_) => _updateOrders(orders.where((o) => o.id != order.id).toList()));
  }
}
