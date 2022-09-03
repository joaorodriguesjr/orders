import 'dart:async';

import 'package:delivery/controllers.dart';
import 'package:flutter/material.dart';
import 'package:inventory/inventory.dart';
import 'package:delivery/instances.dart';
import 'package:delivery/views.dart';

class ListProductsController extends StatefulWidget {
  const ListProductsController({super.key});

  @override
  State<ListProductsController> createState() => ListProductsControllerState();
}

class ListProductsControllerState extends State<ListProductsController> {
  late List<Product> products = [];

  onMainActionPress() {
    Widget builder(innerContext) => const CreateProductController();
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }

  @override
  Widget build(BuildContext context) {
    var query = DataQuery.of<ProductsQuery>(context);

    updateProducts(List<Product> data) => setState(() => products = data);
    _subscription = query.allProducts().listen(updateProducts);

    return ListProductsView(controller: this);
  }

  late StreamSubscription _subscription;

  @override
  void dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}
