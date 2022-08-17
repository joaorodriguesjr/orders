import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/currency.dart';
import '../controllers.dart';

class SelectProductView extends StatelessWidget {
  const SelectProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Produto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: const Card(
        margin: EdgeInsets.all(8),
        child: _ProductsList(),
      ),
    );
  }
}

class _ProductsList extends StatelessWidget {
  const _ProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProductsController>(context);

    return ListView.separated(
      shrinkWrap: true,
      itemCount: controller.products.length,
      itemBuilder: (context, index) {
        var product = controller.products[index];

        return ListTile(
          title: Text(product.description),
          leading: const Icon(Icons.dinner_dining),
          trailing: Currency(value: product.price),
          onTap: () => Navigator.pop(context, product),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
