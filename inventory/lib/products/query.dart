import 'product.dart';

abstract class ProductsQuery {
  Stream<List<Product>> allProducts();
}
