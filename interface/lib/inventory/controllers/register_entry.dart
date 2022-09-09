import 'package:flutter/material.dart';
import 'package:delivery/views.dart';

class RegisterEntryController extends StatefulWidget {
  const RegisterEntryController({Key? key}) : super(key: key);

  @override
  State<RegisterEntryController> createState() =>
      RegisterEntryControllerState();
}

class RegisterEntryControllerState extends State<RegisterEntryController> {
  @override
  Widget build(BuildContext context) {
    return RegisterEntryView(controller: this);
  }
}
