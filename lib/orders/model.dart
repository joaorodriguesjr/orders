import 'package:orders/items/model.dart';

class OrderItem {
  String id = '';
  String description = '';
  int price = 0;
  late int quantity;

  OrderItem(this.id, this.description, this.price) {
    quantity = 1;
  }

  factory OrderItem.from(Item item) {
    return OrderItem(item.id, item.description, item.price);
  }

  increaseQuantity() {
    quantity++;
  }

  decreaseQuantity() {
    quantity--;
  }
}

class Order {
  String id = '';
  String client = '';
  String address = '';
  Map<String, OrderItem> items = {};

  addItem(item) {
    if (items.containsKey(item.id)) {
      items[item.id]?.increaseQuantity();
    } else {
      items[item.id] = OrderItem.from(item);
    }
  }

  int get total {
    return items.values.fold(0, (int total, item) => total + item.price);
  }
}
