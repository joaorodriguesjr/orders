import 'package:inventory/models.dart';
import 'package:inventory/repositories.dart';

class FirestoreProducts implements ProductsRepository {
  @override
  List<Product> all() {
    return [
      Product()
        ..name = 'Milho Verde Quero'
        ..description = 'Lata 120g',
      Product()
        ..name = 'Maionese Quero'
        ..description = 'Sachê 200g',
      Product()
        ..name = 'Maionese Heinz'
        ..description = 'Pote 400g',
      Product()
        ..name = 'Azeitona Vale Fértil'
        ..description = 'Sachê 120g',
    ];
  }
}
