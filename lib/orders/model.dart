import 'package:orders/clients/model.dart';
import 'package:orders/products/model.dart';

class OrderItem {
  String id = '';
  String description = '';
  int price = 0;
  int quantity = 0;

  OrderItem(this.id, this.description, this.price) {
    quantity = 1;
  }

  factory OrderItem.from(Product product) {
    return OrderItem(product.id, product.description, product.price);
  }

  increaseQuantity() {
    quantity++;
  }

  decreaseQuantity() {
    quantity--;
  }
}

class Payment {
  String kind = '';
  String status = '';
}

class Order {
  String id = '';
  Client client = Client();
  Address address = Address();
  Map<String, OrderItem> items = {};
  Payment payment = Payment();
  DateTime datetime = DateTime.now();

  add(Product product) {
    if (items.containsKey(product.id)) {
      return _increaseItemQuantity(product.id);
    }

    items[product.id] = OrderItem.from(product);
  }

  remove(String id) {
    if (items.containsKey(id)) items.remove(id);
  }

  int get total {
    return items.values
        .fold(0, (int total, item) => total + item.price * item.quantity);
  }

  _increaseItemQuantity(String id) {
    items[id]!.increaseQuantity();
  }
}
