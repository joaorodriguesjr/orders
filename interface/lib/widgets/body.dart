import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final List<Widget> children;

  const Body({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(12.0),
        child: Column(children: children),
      ),
    );
  }
}
