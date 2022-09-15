import 'package:delivery/controllers.dart';
import 'package:delivery/icons.dart';
import 'package:delivery/views.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  final DashboardControllerState controller;

  const DashboardView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
      body: const Body(child: Center(child: Text('...'))),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: controller.onCreateEntryPressed,
                icon: Icon(CustomIcons.inventory_in,
                    color: theme.colorScheme.secondary),
              ),
              IconButton(
                onPressed: controller.onCreateExitPressed,
                icon: Icon(CustomIcons.inventory_ou,
                    color: theme.colorScheme.secondary),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onMainActionPressed,
        child: const Icon(CustomIcons.package_plus),
      ),
    );
  }
}
