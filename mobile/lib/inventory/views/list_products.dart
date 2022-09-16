import 'package:flutter/material.dart';
import 'package:inventory/inventory.dart';
import 'package:mobile/controllers.dart';

class ListProductsView extends StatelessWidget {
  final ListProductsControllerState controller;

  const ListProductsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
        ),
        title: const Text('Produtos'),
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

class Body extends StatelessWidget {
  final Widget child;

  const Body({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}

class ProductsList extends StatelessWidget {
  final List<Product> products;

  const ProductsList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var product = products[index];
        return ListTile(
          leading: const Icon(Icons.abc),
          title: Text(product.name),
          subtitle: Text(product.description),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: products.length,
    );
  }
}
