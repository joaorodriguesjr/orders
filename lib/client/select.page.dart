import 'package:flutter/material.dart';
import 'package:orders/clients/provider.dart';
import 'package:provider/provider.dart';

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
        child: _clients(),
      ),
    );
  }

  Widget _clients() {
    return Consumer<ClientsProvider>(builder: (context, provider, _) {
      var clients = provider.clients;

      return ListView.separated(
        itemCount: clients.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(clients[index].name),
          subtitle: Text(clients[index].address.description),
          onTap: () => Navigator.pop(context, clients[index]),
        ),
        separatorBuilder: (context, index) => const Divider(),
      );
    });
  }
}
