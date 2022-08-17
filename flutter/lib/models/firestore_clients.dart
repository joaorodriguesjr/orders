import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/clients.dart';

class FirestoreClients implements ClientsDataSource {
  final collection = FirebaseFirestore.instance.collection('clients');

  @override
  Stream<List<Client>> all() {
    return collection.orderBy('name').snapshots().map(clientsFromSnapshot);
  }

  @override
  Future<void> createClient(Client client) async {
    var doc = await collection.add({
      'name': client.name,
      'phone': client.phone,
      'address': {
        'description': client.address.description,
        'complement': client.address.complement,
      },
    });

    client.id = doc.id;
  }

  @override
  Future<void> updateClient(Client client) async {}

  @override
  Future<void> deleteClient(Client client) async {}
}

List<Client> clientsFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map(clientFromDocument).toList();
}

Client clientFromDocument(DocumentSnapshot doc) {
  var data = doc.data() as Map<String, dynamic>;

  return Client()
    ..id = doc.id
    ..name = data['name']
    ..phone = data['phone']
    ..address.description = data['address']['description']
    ..address.complement = data['address']['complement'];
}
