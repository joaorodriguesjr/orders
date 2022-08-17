import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery/clients.dart';

import '../controllers.dart';

class CreateClientPage extends StatefulWidget {
  const CreateClientPage({Key? key}) : super(key: key);

  @override
  State<CreateClientPage> createState() => _CreateClientPageState();
}

class _CreateClientPageState extends State<CreateClientPage> {
  final _formKey = GlobalKey<FormState>();

  final _client = Client();

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Cliente'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    onSaved: (value) => _client.name = value as String,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Campo obrigatório'
                        : null,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      icon: Icon(Icons.person),
                    ),
                  ),
                  Container(height: 8.0),
                  TextFormField(
                    onSaved: (value) =>
                        _client.address.description = value as String,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Campo obrigatório'
                        : null,
                    decoration: const InputDecoration(
                      labelText: 'Endereço',
                      icon: Icon(Icons.location_on),
                    ),
                  ),
                  Container(height: 8.0),
                  TextFormField(
                    onSaved: (value) =>
                        _client.address.complement = value as String,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Campo obrigatório'
                        : null,
                    decoration: const InputDecoration(
                      labelText: 'Complemento',
                      icon: Icon(Icons.info_outlined),
                    ),
                  ),
                  Container(height: 8.0),
                  TextFormField(
                    onSaved: (value) => _client.phone = value as String,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Campo obrigatório'
                        : null,
                    decoration: const InputDecoration(
                      labelText: 'Telefone',
                      icon: Icon(Icons.phone),
                    ),
                  ),
                  Container(height: 16.0),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          if (_formKey.currentState == null) {
                            return;
                          }

                          var form = _formKey.currentState!;

                          if (!form.validate()) {
                            return;
                          }

                          form.save();
                          var controller = Provider.of<ClientsController>(
                              context,
                              listen: false);
                          await controller.registerClient(_client);
                          navigator.pop(_client);
                        },
                        child: const Text('SALVAR'),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
