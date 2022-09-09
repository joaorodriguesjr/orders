import 'package:flutter/material.dart';
import 'package:delivery/views.dart';

class DashboardController extends StatefulWidget {
  const DashboardController({Key? key}) : super(key: key);

  @override
  State<DashboardController> createState() => DashboardControllerState();
}

class DashboardControllerState extends State<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return DashboardView(controller: this);
  }
}
