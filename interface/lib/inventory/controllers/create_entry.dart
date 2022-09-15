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
      const snackBar = SnackBar(
          content: Text('Selecione um produto para registrar uma entrada.'));
      return ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    final persistence = Persistence.of<RecordsPersistence>(context);
    final record = Record.createEntryRecord(data, product);
    persistence.persist(record);

    Navigator.of(context).pop();
  }

  onScanProductPressed() async {
    final products = DataQuery.of<ProductsQuery>(context);
    final code = await barcodeScan();
    final product = await products.findByCode(code);

    if (product is Product) {
      return setState(() => this.product = product);
    }
  }

  onSelectProductPressed() async {
    final selection = await Navigator.of(context)
        .pushNamed('inventory/products/select') as Product?;

    if (selection == null) {
      return;
    }

    setState(() => product = selection);
  }

  @override
  Widget build(BuildContext context) {
    return CreateEntryView(controller: this);
  }
}
