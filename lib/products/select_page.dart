import 'package:flutter/material.dart';
import 'package:orders/products/provider.dart';
import 'package:provider/provider.dart';

class SelectProductPage extends StatefulWidget {
  const SelectProductPage({Key? key}) : super(key: key);

  @override
  State<SelectProductPage> createState() => _SelectProductPageState();
}

class _SelectProductPageState extends State<SelectProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Produto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Card(
        child: _products(),
      ),
    );
  }

  Widget _products() {
    return Consumer<ProductsProvider>(builder: (context, provider, _) {
      var products = provider.products;

      return ListView.separated(
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(products[index].description),
          trailing: Text(products[index].price.toString()),
          onTap: () => Navigator.pop(context, products[index]),
        ),
        separatorBuilder: (context, index) => const Divider(),
      );
    });
  }
}
