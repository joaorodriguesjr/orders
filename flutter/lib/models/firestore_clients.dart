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
    var doc = await collection.add(client.data());
    client.id = doc.id;
  }

  @override
  Future<void> updateClient(Client client) async {}

  @override
  Future<void> deleteClient(Client client) async {
    await collection.doc(client.id).delete();
  }
}

List<Client> clientsFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map(clientFromDocument).toList();
}

Client clientFromDocument(DocumentSnapshot doc) {
  return Client.restore(doc.id, doc.data() as Map<String, dynamic>);
}
