import 'package:mobile/controllers.dart';
import 'package:mobile/forms.dart';
import 'package:mobile/views.dart';
import 'package:flutter/material.dart';

class CreateProductView extends StatelessWidget {
  final CreateProductControllerState controller;

  const CreateProductView({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Produto'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Body(child: CreateProductForm(onFormData: controller.onFormData)),
    );
  }
}
