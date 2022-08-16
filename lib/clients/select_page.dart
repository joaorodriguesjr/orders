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
            onPressed: () async {
              var client = await showSearch(
                  context: context, delegate: _SearchClientDelegate());

              navigator.pop(client);
            },
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
        itemBuilder: (context, index) => Dismissible(
          key: Key(clients[index].id),
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Theme.of(context).primaryColor,
            child: const ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              leading: Icon(Icons.delete),
            ),
          ),
          onDismissed: (direction) async {
            await provider.deleteClient(clients[index]);
          },
          confirmDismiss: (direction) async {
            final result = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Excluir Cliente'),
                content: const Text('Confirmar a exclusão permanente?'),
                actions: [
                  TextButton(
                    child: const Text('Não'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                    child: const Text('Sim'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            );
            return result;
          },
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            leading: Container(
                height: double.infinity, child: const Icon(Icons.person)),
            title: Text(clients[index].name),
            subtitle: Text(clients[index].address.description,
                overflow: TextOverflow.ellipsis),
            onTap: () => Navigator.pop(context, clients[index]),
          ),
        ),
        separatorBuilder: (context, index) => const Divider(height: 0.0),
      );
    });
  }
}

class _SearchClientDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var provider = Provider.of<ClientsProvider>(context);
    var suggestions = provider.clients
        .where((client) => client.name.toLowerCase().contains(query))
        .toList();

    return Card(
      margin: const EdgeInsets.all(8),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: suggestions.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.person),
          title: Text(suggestions[index].name),
          subtitle: Text(suggestions[index].address.description,
              overflow: TextOverflow.ellipsis),
          onTap: () => close(context, suggestions[index]),
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
