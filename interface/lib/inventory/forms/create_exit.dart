import 'package:flutter/material.dart';

class CreateExitForm extends StatefulWidget {
  final Function(Map<String, dynamic> data) onFormData;

  const CreateExitForm({super.key, required this.onFormData});

  @override
  State<CreateExitForm> createState() => _CreateExitFormState();
}

class _CreateExitFormState extends State<CreateExitForm> {
  final _key = GlobalKey<FormState>();

  final _data = <String, dynamic>{};

  onSaveButtonPressed() async {
    var form = _key.currentState!;

    if (form.validate() == false) {
      return;
    }

    form.save();
    widget.onFormData(_data);
  }

  fieldSaveDouble(String name) {
    return (value) => _data[name] = double.parse(value);
  }

  String? validateDouble(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    final number = double.tryParse(value);

    if (number == null) {
      return 'Valor numérico inválido';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(children: [
        ListTile(
          title: TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Quantidade'),
            validator: validateDouble,
            onSaved: fieldSaveDouble('quantity'),
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
}
