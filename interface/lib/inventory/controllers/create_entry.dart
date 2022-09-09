import 'package:flutter/material.dart';
import 'package:delivery/views.dart';

class CreateEntryController extends StatefulWidget {
  const CreateEntryController({Key? key}) : super(key: key);

  @override
  State<CreateEntryController> createState() => CreateEntryControllerState();
}

class CreateEntryControllerState extends State<CreateEntryController> {
  @override
  Widget build(BuildContext context) {
    return CreateEntryView(controller: this);
  }
}
