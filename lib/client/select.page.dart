import 'package:flutter/material.dart';

class SelectClientPage extends StatefulWidget {
  const SelectClientPage({Key? key}) : super(key: key);

  @override
  State<SelectClientPage> createState() => _SelectClientPageState();
}

class _SelectClientPageState extends State<SelectClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Cliente'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Card(
        child: ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) => ListTile(
            title: Text('Cliente #${index + 1}'),
            subtitle: Text('Endereço do cliente #${index + 1}'),
            onTap: () => Navigator.pop(context, 'Cliente #${index + 1}'),
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
