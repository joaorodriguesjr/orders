import 'package:inventory/models.dart';

abstract class ProductsRepository {
  Stream<List<Product>> allProducts();
}
