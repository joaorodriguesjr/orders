import 'package:flutter/material.dart';
import 'package:inventory/controllers.dart';
import 'package:inventory/widgets.dart';

class ListProductsView extends StatelessWidget {
  final ListProductsControllerState controller;

  const ListProductsView({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
        ),
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Body(
        child: ProductsList(products: controller.products),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onMainActionPress,
        child: const Icon(Icons.add),
      ),
    );
  }
}
