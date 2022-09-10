import 'package:delivery/controllers.dart';
import 'package:delivery/forms.dart';
import 'package:delivery/views.dart';
import 'package:flutter/material.dart';

class CreateEntryView extends StatelessWidget {
  final CreateEntryControllerState controller;

  const CreateEntryView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Entrada'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Body(
          child: Column(
        children: [
          ListTile(
            title: Text(controller.product.name),
            subtitle: Text(controller.product.description),
            trailing: Wrap(children: [
              IconButton(
                onPressed: controller.onScanProductPressed,
                icon: const Icon(Icons.qr_code_scanner),
              ),
              IconButton(
                onPressed: controller.onSelectProductPressed,
                icon: const Icon(Icons.search),
              ),
            ]),
          ),
          CreateEntryForm(onFormData: controller.onFormData),
        ],
      )),
    );
  }
}
