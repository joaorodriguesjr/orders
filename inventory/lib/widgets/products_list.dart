import 'package:flutter/material.dart';
import 'package:inventory/models.dart';

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
