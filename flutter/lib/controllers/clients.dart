import 'package:flutter/material.dart';
import 'package:delivery/clients.dart';

class ClientsController extends ChangeNotifier {
  List<Client> clients = [];

  ClientsDataSource dataSource;

  ClientsController(this.dataSource) {
    dataSource.all().listen(_updateClients);
  }

  _updateClients(clients) {
    this.clients = clients;
    notifyListeners();
  }

  registerClient(Client client) async {
    await dataSource.createClient(client);
  }

  deleteClient(Client client) async {
    await dataSource.deleteClient(client);
  }
}
