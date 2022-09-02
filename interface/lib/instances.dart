export 'package:provider/provider.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:data/data.dart';
import 'package:inventory/inventory.dart' as inventory;
import 'package:data/inventory.dart' as data_inventory;

var _providers = [
  Provider<inventory.ProductsQuery>(
    create: (_) {
      return data_inventory.FirestoreProducts(
          inventoryFirestore.collection('products'));
    },
  ),
];

Widget withInstances(Widget child) {
  return MultiProvider(providers: _providers, child: child);
}

class DataQuery {
  static Type of<Type>(BuildContext context) => Provider.of<Type>(context);
}
