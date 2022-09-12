import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inventory/inventory.dart';
import 'package:delivery/instances.dart';
import 'package:delivery/views.dart';

class SelectProductController extends StatefulWidget {
  const SelectProductController({super.key});

  @override
  State<SelectProductController> createState() =>
      SelectProductControllerState();
}

class SelectProductControllerState extends State<SelectProductController> {
  late List<Product> products = [];

  onMainActionPress() {
    Navigator.of(context).pushNamed('inventory/products/create');
  }

  onProductSelected(Product product) {
    Navigator.of(context).pop(product);
  }

  @override
  Widget build(BuildContext context) {
    var query = DataQuery.of<ProductsQuery>(context);

    updateProducts(List<Product> data) => setState(() => products = data);
    _subscription = query.allProducts().listen(updateProducts);

    return SelectProductView(controller: this);
  }

  late StreamSubscription _subscription;

  @override
  void dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}
