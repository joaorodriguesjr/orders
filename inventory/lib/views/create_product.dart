import 'package:flutter/material.dart';
import 'package:inventory/controllers.dart';
import 'package:inventory/widgets.dart';

class CreateProductView extends StatelessWidget {
  final CreateProductControllerState controller;

  const CreateProductView({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: const Body(child: ListTile(title: Text('...'))),
    );
  }
}
