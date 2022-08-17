import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/pages/list_orders.dart';
import 'package:app/orders/provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'controllers.dart';
import 'clients/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 158, 46, 46)),
      ).copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240)),
      home: const ListOrdersPage(),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ClientsProvider>(
            create: (_) => ClientsProvider()),
        ChangeNotifierProvider<OrdersProvider>(create: (_) => OrdersProvider()),
        ChangeNotifierProvider<ProductsController>(
            create: (_) => ProductsController(FirestoreProducts())),
        ChangeNotifierProvider<ClientsController>(
            create: (_) => ClientsController(FirestoreClients())),
      ],
      child: app,
    );
  }
}
