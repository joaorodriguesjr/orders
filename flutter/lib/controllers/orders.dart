import 'dart:async';

import 'package:flutter/material.dart';
import 'package:delivery/orders.dart';

class OrdersController extends ChangeNotifier {
  final OrdersDataSource _dataSource;

  late StreamSubscription _subscription;

  DateTime _ordersDay = today();

  OrdersController(this._dataSource) {
    _subscription =
        _dataSource.ordersFrom(day: _ordersDay).listen(_updateOrders);
  }

  _updateOrders(orders) {
    this.orders = orders;
    notifyListeners();
  }

  List<Order> orders = [];

  DateTime get ordersDay => _ordersDay;

  registerOrder(Order order) async {
    await _dataSource.createOrder(order);
  }

  changeOrdersDay(DateTime day) async {
    _ordersDay = day;

    await _subscription.cancel();

    _subscription =
        _dataSource.ordersFrom(day: _ordersDay).listen(_updateOrders);
  }
}

DateTime today() {
  var now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}
