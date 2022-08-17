import 'package:provider/provider.dart';

import 'controllers/products.dart';
import 'models/firestore_products.dart';

import 'controllers/clients.dart';
import 'models/firestore_clients.dart';

import 'controllers/orders.dart';
import 'models/firestore_orders.dart';

var providers = [
  ChangeNotifierProvider<ProductsController>(
    create: (_) => ProductsController(FirestoreProducts()),
  ),
  ChangeNotifierProvider<ClientsController>(
    create: (_) => ClientsController(FirestoreClients()),
  ),
  ChangeNotifierProvider<OrdersController>(
    create: (_) => OrdersController(FirestoreOrders()),
  ),
];
