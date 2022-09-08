import 'product.dart';

abstract class ProductsPersistence {
  Future<void> persist(Product product);
}
