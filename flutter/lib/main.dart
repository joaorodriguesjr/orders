import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'views/list_orders.dart';
import 'providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var seedColor = const Color.fromARGB(255, 158, 46, 46);
    var background = const Color.fromARGB(255, 240, 240, 240);
    var colorScheme = ColorScheme.fromSeed(seedColor: seedColor);

    var theme = ThemeData.from(colorScheme: colorScheme)
        .copyWith(scaffoldBackgroundColor: background);

    var app = MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const ListOrdersView(),
    );

    return MultiProvider(providers: providers, child: app);
  }
}
