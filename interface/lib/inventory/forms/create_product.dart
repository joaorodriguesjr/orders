import 'package:delivery/helpers.dart';
import 'package:flutter/material.dart';

class CreateProductForm extends StatefulWidget {
  final Function(Map<String, dynamic> data) onFormData;

  const CreateProductForm({super.key, required this.onFormData});

  @override
  State<CreateProductForm> createState() => _CreateProductFormState();
}

class _CreateProductFormState extends State<CreateProductForm> {
  final _key = GlobalKey<FormState>();

  final _barcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(children: [
        ListTile(
          leading: const Icon(Icons.onetwothree),
          title: TextFormField(
            controller: _barcodeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Código'),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () async {
              _barcodeController.text = await barcodeScan();
            },
          ),
        )
      ]),
    );
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }
}
