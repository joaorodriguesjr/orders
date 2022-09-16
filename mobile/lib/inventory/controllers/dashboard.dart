import 'package:flutter/material.dart';
import 'package:mobile/views.dart';

class DashboardController extends StatefulWidget {
  const DashboardController({Key? key}) : super(key: key);

  @override
  State<DashboardController> createState() => DashboardControllerState();
}

class DashboardControllerState extends State<DashboardController> {
  onMainActionPressed() {
    Navigator.of(context).pushNamed('inventory/products/create');
  }

  onCreateEntryPressed() {
    Navigator.of(context).pushNamed('inventory/records/entry');
  }

  onCreateExitPressed() {
    Navigator.of(context).pushNamed('inventory/records/exit');
  }

  @override
  Widget build(BuildContext context) {
    return DashboardView(controller: this);
  }
}
