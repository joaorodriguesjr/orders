import '../clients.dart';
import '../products.dart';

class Item {
  Product product = Product();
  int quantity = 1;

  Item();

  factory Item.from(Product product) {
    var item = Item()..product = product;
    return item;
  }

  factory Item.fromData(
      String id, String description, int price, int quantity) {
    var product = Product.fromData(id, description, price);
    var item = Item()
      ..product = product
      ..quantity = quantity;

    return item;
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
  Map<String, Item> items = {};
  Payment payment = Payment();
  DateTime datetime = DateTime.now();

  add(Product product) {
    if (items.containsKey(product.id)) {
      return _increaseItemQuantity(product.id);
    }

    items[product.id] = Item.from(product);
  }

  remove(String id) {
    if (items.containsKey(id)) items.remove(id);
  }

  int get total {
    return items.values.fold(
        0, (int total, item) => total + item.product.price * item.quantity);
  }

  _increaseItemQuantity(String id) {
    items[id]!.increaseQuantity();
  }
}
