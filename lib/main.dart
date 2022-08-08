import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orders/orders/list.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 158, 46, 46)),
      ).copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240)),
      home: const ListOrdersPage(),
    );
  }
}
