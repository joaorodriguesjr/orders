import 'product.dart';

abstract class ProductsQueries {
  Stream<List<Product>> allProducts();
}
