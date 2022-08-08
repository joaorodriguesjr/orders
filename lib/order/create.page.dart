import 'package:flutter/material.dart';
import 'package:orders/client/select.page.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  int _step = 0;

  String? _client;

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
            content: (_client == null)
                ? OutlinedButton(
                    onPressed: () async {
                      final client = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectClientPage(),
                        ),
                      );
                      if (client != null) {
                        setState(() {
                          _client = client;
                        });
                      }
                    },
                    child: const Text('SELECIONAR CLIENTE'))
                : Text('$_client'),
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
}
