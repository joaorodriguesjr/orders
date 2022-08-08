import 'package:flutter/material.dart';
import 'package:orders/client/select.page.dart';
import 'package:orders/clients/model.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  int _step = 0;

  Client? _client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Pedido'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Stepper(
        currentStep: _step,
        onStepTapped: (index) => setState(() => _step = index),
        controlsBuilder: (context, details) => Container(),
        steps: [
          Step(
            title: const Text('Cliente'),
            content: _clientSelection(),
            isActive: true,
          ),
          Step(
            title: const Text('Itens'),
            content: const Text('...2'),
            isActive: (_client != null),
          ),
        ],
      ),
    );
  }

  Widget _clientSelection() {
    return (_client == null)
        ? OutlinedButton(
            onPressed: () async {
              var client = await Navigator.push<Client>(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectClientPage(),
                ),
              );

              setState(() => _client = client);
            },
            child: const Text('SELECIONAR CLIENTE'))
        : ListTile(
            title: Text(_client!.name),
            subtitle: Text(_client!.address.description),
            leading: const Icon(Icons.person),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => setState(() => _client = null),
            ),
          );
  }
}
