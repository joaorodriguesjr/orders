import 'product.dart';

abstract class ProductsQuery {
  Stream<List<Product>> allProducts();

  Future<Product?> findByCode(String code);
}
