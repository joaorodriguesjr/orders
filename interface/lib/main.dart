import 'package:flutter/material.dart';
import 'package:data/data.dart';

import 'instances.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeAppData();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var seed = const Color.fromARGB(255, 158, 46, 46);
    var back = const Color.fromARGB(255, 240, 240, 240);

    var app = MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorSchemeSeed: seed, scaffoldBackgroundColor: back),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(),
    );

    return withInstances(app);
  }
}
