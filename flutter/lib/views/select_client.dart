import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery/clients.dart';

import 'create_client.dart';
import '../controllers.dart';

class SelectClientView extends StatelessWidget {
  const SelectClientView({Key? key}) : super(key: key);

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

              if (client == null) return;

              navigator.pop(client);
            },
          ),
        ],
      ),
      body: const Card(
        margin: EdgeInsets.all(8),
        child: ClientsList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final client = await navigator.push(
            MaterialPageRoute(builder: (context) => const CreateClientView()),
          );

          if (client == null) return;

          navigator.pop(client);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ClientsList extends StatelessWidget {
  const ClientsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ClientsController>(context);

    return ListView.separated(
      shrinkWrap: true,
      itemCount: controller.clients.length,
      itemBuilder: (context, index) =>
          DismissibleClient(client: controller.clients[index]),
      separatorBuilder: (context, index) => const Divider(height: 0.0),
    );
  }
}

class DismissibleClient extends StatelessWidget {
  final Client client;

  const DismissibleClient({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ClientsController>(context);

    return Dismissible(
      key: Key(client.id),
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
        await controller.deleteClient(client);
      },
      confirmDismiss: (direction) async {
        final result = await showDialog(
          context: context,
          builder: (context) => ClientExclusionAlert(client: client),
        );
        return result;
      },
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        leading:
            Container(height: double.infinity, child: const Icon(Icons.person)),
        title: Text(client.name),
        subtitle:
            Text(client.address.description, overflow: TextOverflow.ellipsis),
        onTap: () {
          Navigator.pop(context, client);
        },
      ),
    );
  }
}

class ClientExclusionAlert extends StatelessWidget {
  final Client client;

  const ClientExclusionAlert({Key? key, required this.client})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
    );
  }
}

class _SearchClientDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          (query.isEmpty) ? close(context, null) : query = '';
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
    return SearchClientsList(
      query: query,
      onClientTap: (client) => close(context, client),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchClientsList(
      query: query,
      onClientTap: (client) => close(context, client),
    );
  }
}

class SearchClientsList extends StatelessWidget {
  final String query;

  final Function(Client) onClientTap;

  const SearchClientsList(
      {Key? key, required this.query, required this.onClientTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ClientsController>(context);
    var filtered = controller.clients
        .where((client) => client.name.toLowerCase().contains(query))
        .toList();

    return Card(
      margin: const EdgeInsets.all(8),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: filtered.length,
        itemBuilder: (context, index) => ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          leading: Container(
              height: double.infinity, child: const Icon(Icons.person)),
          title: Text(filtered[index].name),
          subtitle: Text(filtered[index].address.description,
              overflow: TextOverflow.ellipsis),
          onTap: () => onClientTap(filtered[index]),
        ),
        separatorBuilder: (context, index) => const Divider(height: 0.0),
      ),
    );
  }
}
