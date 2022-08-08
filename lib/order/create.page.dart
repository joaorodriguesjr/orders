import 'package:flutter/material.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  int _step = 0;

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
            content: OutlinedButton(
                onPressed: () {}, child: const Text('SELECIONAR CLIENTE')),
            isActive: true,
          ),
          const Step(
            title: Text('Itens'),
            content: Text('...2'),
            isActive: true,
          ),
        ],
      ),
    );
  }
}
