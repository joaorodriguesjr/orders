import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/orders.dart';

class FirestoreOrders implements OrdersDataSource {
  final collection = FirebaseFirestore.instance.collection('orders');

  @override
  Stream<List<Order>> ordersFrom({required DateTime day}) {
    return collection
        .where('datetime', isGreaterThanOrEqualTo: day)
        .where('datetime', isLessThan: day.add(const Duration(days: 1)))
        .snapshots()
        .map(ordersFromSnapshot);
  }

  @override
  Future<void> createOrder(Order order) async {
    var doc = await collection.add(orderToMap(order));
    order.id = doc.id;
  }

  @override
  Future<void> updateOrder(Order order) async {}

  @override
  Future<void> deleteOrder(Order order) async {}
}

List<Order> ordersFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map(orderFromDocument).toList();
}

Order orderFromDocument(DocumentSnapshot doc) {
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

Map<String, dynamic> orderToMap(Order order) {
  return {
    'client': {
      'id': order.client.id,
      'name': order.client.name,
      'phone': order.client.phone,
    },
    'address': {
      'description': order.client.address.description,
      'complement': order.client.address.complement,
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
}
