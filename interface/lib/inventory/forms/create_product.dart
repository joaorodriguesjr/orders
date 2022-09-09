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

  final _data = <String, dynamic>{};

  onScanButtonPressed() async {
    var scan = await barcodeScan();

    if (scan == '-1') {
      return;
    }

    _barcodeController.text = scan;
  }

  onSaveButtonPressed() async {
    var form = _key.currentState!;

    if (form.validate() == false) {
      return;
    }

    form.save();
    widget.onFormData(_data);
  }

  fieldSave(String name) {
    return (value) => _data[name] = value;
  }

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
            validator: requiredField,
            onSaved: fieldSave('code'),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: onScanButtonPressed,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.abc),
          title: TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(labelText: 'Produto'),
            validator: requiredField,
            onSaved: fieldSave('name'),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.subtitles),
          title: TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(labelText: 'Descrição'),
            validator: requiredField,
            onSaved: fieldSave('description'),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: onSaveButtonPressed,
              child: const Text('SALVAR'),
            ),
          ],
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }
}

String? requiredField(String? value) {
  return (value == null || value.isEmpty) ? 'Campo obrigatório' : null;
}
