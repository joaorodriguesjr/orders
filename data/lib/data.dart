export 'inventory/firestore_products.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase/options.dart';

initializeAppData() async {
  await Firebase.initializeApp(options: OrdersFirebaseOptions.currentPlatform);

  await Firebase.initializeApp(
      name: 'inventory', options: InventoryFirebaseOptions.currentPlatform);
}

var _ordersApp = Firebase.app('orders');
var ordersFirestore = FirebaseFirestore.instanceFor(app: _ordersApp);

var _inventoryApp = Firebase.app('inventory');
var inventoryFirestore = FirebaseFirestore.instanceFor(app: _inventoryApp);
