import 'package:flutter/material.dart';

class CreateProductForm extends StatefulWidget {
  final Function(Map<String, dynamic> data) onFormData;

  const CreateProductForm({super.key, required this.onFormData});

  @override
  State<CreateProductForm> createState() => _CreateProductFormState();
}

class _CreateProductFormState extends State<CreateProductForm> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(children: const []),
    );
  }
}
