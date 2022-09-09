import 'package:flutter/material.dart';
import 'package:inventory/inventory.dart';
import 'package:delivery/instances.dart';
import 'package:delivery/views.dart';

class CreateProductController extends StatefulWidget {
  const CreateProductController({Key? key}) : super(key: key);

  @override
  State<CreateProductController> createState() =>
      CreateProductControllerState();
}

class CreateProductControllerState extends State<CreateProductController> {
  onFormData(Map<String, dynamic> data) {
    final navigator = Navigator.of(context);

    final persistence = Persistence.of<ProductsPersistence>(context);
    final product = Product.create(data);

    persistence.persist(product);
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return CreateProductView(controller: this);
  }
}
