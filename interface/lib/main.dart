import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var seed = const Color.fromARGB(255, 158, 46, 46);
    var back = const Color.fromARGB(255, 240, 240, 240);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorSchemeSeed: seed, scaffoldBackgroundColor: back),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(),
    );
  }
}
