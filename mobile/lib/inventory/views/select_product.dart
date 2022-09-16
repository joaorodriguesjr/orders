import 'package:flutter/material.dart';
import 'package:mobile/controllers.dart';
import 'package:mobile/widgets.dart';

class SelectProductView extends StatelessWidget {
  final SelectProductControllerState controller;

  const SelectProductView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Produto'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Body(
        children: [
          ProductsList(
              products: controller.products,
              onProductTap: controller.onProductSelected),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onMainActionPress,
        child: const Icon(Icons.add),
      ),
    );
  }
}
