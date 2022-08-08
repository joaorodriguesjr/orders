import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orders/clients/model.dart';

class ClientsProvider extends ChangeNotifier {
  List<Client> clients = [];

  ClientsProvider() {
    _loadClients();
  }

  _loadClients() async {
    var snapshot = await FirebaseFirestore.instance.collection('clients').get();

    clients = snapshot.docs.map((doc) {
      var data = doc.data();
      var client = Client();
      client.id = doc.id;
      client.name = data['name'];
      client.address.description = data['address']['description'];
      client.address.complement = data['address']['complement'];
      return client;
    }).toList();

    notifyListeners();
  }
}
