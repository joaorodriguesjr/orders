import 'package:flutter/material.dart';
import 'package:inventory/controllers.dart';

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
      body: const SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(12.0),
          child: ListTile(title: Text('...')),
        ),
      ),
    );
  }
}
