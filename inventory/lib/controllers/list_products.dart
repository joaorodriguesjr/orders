import 'package:flutter/material.dart';
import 'package:inventory/inventory.dart';

class ListProductsController extends StatefulWidget {
  const ListProductsController({Key? key}) : super(key: key);

  @override
  State<ListProductsController> createState() => ListProductsControllerState();
}

class ListProductsControllerState extends State<ListProductsController> {
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    var repository = Repository.of<ProductsRepository>(context);
    setState(() => products = repository.all());
    return ListProductsView(controller: this);
  }

  onMainActionPress() async {
    Widget builder(context) {
      return const AlertDialog(content: Text('...'));
    }

    await showDialog(context: context, builder: builder);
  }
}
