import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inventory/inventory.dart';

class ListProductsController extends StatefulWidget {
  const ListProductsController({Key? key}) : super(key: key);

  @override
  State<ListProductsController> createState() => ListProductsControllerState();
}

class ListProductsControllerState extends State<ListProductsController> {
  List<Product> products = [];

  late StreamSubscription<List<Product>> _subscription;

  @override
  Widget build(BuildContext context) {
    var repository = Repository.of<ProductsRepository>(context);

    _subscription = repository.allProducts().listen((products) {
      setState(() => this.products = products);
    });

    return ListProductsView(controller: this);
  }

  @override
  void dispose() async {
    await _subscription.cancel();
    super.dispose();
  }

  onMainActionPress() {
    Widget builder(innerContext) => const CreateProductController();
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }
}
