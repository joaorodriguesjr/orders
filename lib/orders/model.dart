import 'package:orders/clients/model.dart';
import 'package:orders/items/model.dart';

class OrderItem {
  String id = '';
  String description = '';
  int price = 0;
  int quantity = 0;

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
  Client client = Client();
  Address address = Address();
  Map<String, OrderItem> items = {};

  add(Item item) {
    if (items.containsKey(item.id)) {
      return _increaseItemQuantity(item.id);
    }

    items[item.id] = OrderItem.from(item);
  }

  remove(String id) {
    if (items.containsKey(id)) items.remove(id);
  }

  int get total {
    return items.values.fold(0, (int total, item) => total + item.price);
  }

  _increaseItemQuantity(String id) {
    items[id]!.increaseQuantity();
  }
}
