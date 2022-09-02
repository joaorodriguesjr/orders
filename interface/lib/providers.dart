export 'package:provider/provider.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:data/data.dart';
import 'package:inventory/inventory.dart' as inventory;
import 'package:data/inventory.dart' as data_inventory;

var providers = [
  Provider<inventory.ProductsQueries>(
    create: (_) {
      return data_inventory.FirestoreProducts(
          inventoryFirestore.collection('products'));
    },
  ),
];

class DataQuery {
  static of<Type>(BuildContext context) => Provider.of<Type>(context);
}
