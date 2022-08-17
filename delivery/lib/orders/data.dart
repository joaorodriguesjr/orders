import 'models.dart';

abstract class OrdersDataSource {
  Stream<List<Order>> ordersFrom({required DateTime day});

  Future<void> createOrder(Order order);
  Future<void> updateOrder(Order order);
  Future<void> deleteOrder(Order order);
}
