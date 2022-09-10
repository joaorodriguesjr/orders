import 'package:flutter/material.dart';
import 'package:inventory/inventory.dart';
import 'package:delivery/instances.dart';
import 'package:delivery/helpers.dart';
import 'package:delivery/views.dart';

class CreateEntryController extends StatefulWidget {
  const CreateEntryController({Key? key}) : super(key: key);

  @override
  State<CreateEntryController> createState() => CreateEntryControllerState();
}

class CreateEntryControllerState extends State<CreateEntryController> {
  Product product = Product()
    ..name = 'Produto'
    ..description = 'Selectionar um produto';

  onFormData(Map<String, dynamic> data) async {
    if (product.code.isEmpty) {
      return;
    }

    Navigator.of(context).pop();
  }

  onScanProductPressed() async {
    final products = DataQuery.of<ProductsQuery>(context);
    final code = await barcodeScan();
    final product = await products.findByCode(code);

    if (product != null) setState(() => this.product = product);
  }

  onSelectProductPressed() {
    Navigator.of(context).pushNamed('inventory/products');
  }

  @override
  Widget build(BuildContext context) {
    return CreateEntryView(controller: this);
  }
}
