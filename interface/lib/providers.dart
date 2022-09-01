export 'package:provider/provider.dart';

import 'package:data/data.dart';
import 'package:provider/provider.dart';
import 'package:inventory/inventory.dart' as inventory;

var providers = [
  Provider<inventory.ProductsQueries>(
    create: (_) {
      return FirestoreProducts(inventoryFirestore.collection('products'));
    },
  ),
];
