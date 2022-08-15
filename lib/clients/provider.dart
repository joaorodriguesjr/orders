import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orders/clients/model.dart';

class ClientsProvider extends ChangeNotifier {
  List<Client> clients = [];

  ClientsProvider() {
    _loadClients();
  }

  _loadClients() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('clients')
        .orderBy('name')
        .get();

    clients = snapshot.docs.map((doc) {
      var data = doc.data();
      var client = Client();
      client.id = doc.id;
      client.name = data['name'];
      client.phone = data['phone'];
      client.address.description = data['address']['description'];
      client.address.complement = data['address']['complement'];
      return client;
    }).toList();

    notifyListeners();
  }

  registerClient(Client client) async {
    var doc = await FirebaseFirestore.instance.collection('clients').add({
      'name': client.name,
      'phone': client.phone,
      'address': {
        'description': client.address.description,
        'complement': client.address.complement,
      },
    });

    client.id = doc.id;
    clients.add(client);

    notifyListeners();
  }
}
