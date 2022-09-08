export 'package:provider/provider.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:data/data.dart';
import 'package:inventory/inventory.dart' as inventory;
import 'package:data/inventory.dart' as data_inventory;

var _providers = [
  Provider<data_inventory.FirestoreProducts>(
    create: (_) => data_inventory.FirestoreProducts(
        inventoryFirestore.collection('products')),
  ),
  Provider<inventory.ProductsQuery>(
    create: (context) =>
        Provider.of<data_inventory.FirestoreProducts>(context, listen: false),
  ),
  Provider<inventory.ProductsPersistence>(
    create: (context) =>
        Provider.of<data_inventory.FirestoreProducts>(context, listen: false),
  ),
];

Widget withInstances(Widget child) {
  return MultiProvider(providers: _providers, child: child);
}

class DataQuery {
  static Type of<Type>(BuildContext context) =>
      Provider.of<Type>(context, listen: false);
}

class Persistence {
  static Type of<Type>(BuildContext context) =>
      Provider.of<Type>(context, listen: false);
}
