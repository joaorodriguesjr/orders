import 'package:delivery/controllers.dart';
import 'package:delivery/views.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  final DashboardControllerState controller;

  const DashboardView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.dashboard),
          onPressed: () {},
        ),
        title: const Text('Estoque'),
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
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: controller.onCreateEntryPressed,
                icon: const Icon(Icons.keyboard_double_arrow_down),
                label: const Text('ENTRADA'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_double_arrow_up),
                label: const Text('SAÍDA'),
              ),
            ],
          )
        ],
      )),
    );
  }
}
