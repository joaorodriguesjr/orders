import 'package:flutter/material.dart';
import 'package:inventory/inventory.dart';

class ProductsList extends StatelessWidget {
  final List<Product> products;

  final Function(Product) onProductTap;

  const ProductsList(
      {Key? key, required this.products, required this.onProductTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        var product = products[index];
        return ListTile(
          onTap: () => onProductTap(product),
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
