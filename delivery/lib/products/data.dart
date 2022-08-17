import 'models.dart';

abstract class OrdersDataSource {
  Stream<List<Product>> all();

  Future<void> createProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(Product product);
}
