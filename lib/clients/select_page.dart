import 'package:flutter/material.dart';
import 'package:orders/clients/create_page.dart';
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
    var navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Cliente'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Card(
        margin: const EdgeInsets.all(8),
        child: _clients(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final client = await navigator.push(
            MaterialPageRoute(builder: (context) => const CreateClientPage()),
          );

          if (client == null) return;

          navigator.pop(client);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _clients() {
    return Consumer<ClientsProvider>(builder: (context, provider, _) {
      var clients = provider.clients;

      return ListView.separated(
        shrinkWrap: true,
        itemCount: clients.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.person),
          title: Text(clients[index].name),
          subtitle: Text(clients[index].address.description,
              overflow: TextOverflow.ellipsis),
          onTap: () => Navigator.pop(context, clients[index]),
        ),
        separatorBuilder: (context, index) => const Divider(),
      );
    });
  }
}
