import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orders/orders/list.page.dart';
import 'package:orders/orders/provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'clients/provider.dart';
import 'items/provider.dart';

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
        ChangeNotifierProvider<ItemsProvider>(create: (_) => ItemsProvider()),
        ChangeNotifierProvider<OrdersProvider>(create: (_) => OrdersProvider()),
      ],
      child: app,
    );
  }
}
