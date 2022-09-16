import 'package:mobile/controllers.dart';
import 'package:mobile/forms.dart';
import 'package:mobile/views.dart';
import 'package:flutter/material.dart';

class CreateExitView extends StatelessWidget {
  final CreateExitControllerState controller;

  const CreateExitView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Saída'),
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
          CreateExitForm(onFormData: controller.onFormData),
        ],
      )),
    );
  }
}
