import 'package:flutter/material.dart';
import 'package:inventory/inventory.dart';
import 'package:delivery/views.dart';

class CreateProductController extends StatefulWidget {
  const CreateProductController({Key? key}) : super(key: key);

  @override
  State<CreateProductController> createState() =>
      CreateProductControllerState();
}

class CreateProductControllerState extends State<CreateProductController> {
  Product product = Product();

  @override
  Widget build(BuildContext context) {
    return CreateProductView(controller: this);
  }
}
