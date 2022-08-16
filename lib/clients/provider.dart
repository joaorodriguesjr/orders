import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:delivery/clients/model.dart';

class ClientsProvider extends ChangeNotifier {
  List<Client> clients = [];

  late StreamSubscription<List<Client>> _subscription;

  ClientsProvider() {
    _subscription = _stream().listen(_updateClients);
  }

  _updateClients(List<Client> clients) {
    this.clients = clients;
    notifyListeners();
  }

  Stream<List<Client>> _stream() {
    return FirebaseFirestore.instance
        .collection('clients')
        .orderBy('name')
        .snapshots()
        .map(_mapSnapshot);
  }

  List<Client> _mapSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(_clientFromDocument).toList();
  }

  Client _clientFromDocument(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;

    return Client()
      ..id = doc.id
      ..name = data['name']
      ..phone = data['phone']
      ..address.description = data['address']['description']
      ..address.complement = data['address']['complement'];
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

  deleteClient(Client client) async {
    await FirebaseFirestore.instance
        .collection('clients')
        .doc(client.id)
        .delete();
  }
}
