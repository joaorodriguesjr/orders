import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/models.dart';
import 'package:inventory/repositories.dart';

class FirestoreProducts implements ProductsRepository {
  final CollectionReference collection;

  FirestoreProducts(this.collection);

  @override
  Stream<List<Product>> allProducts() {
    return collection.snapshots().map(productsFromSnapshot);
  }
}

List<Product> productsFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map(productFromDocument).toList();
}

Product productFromDocument(DocumentSnapshot doc) {
  var data = doc.data() as Map<String, dynamic>;

  return Product()
    ..code = doc.id
    ..name = data['name']
    ..description = data['description'];
}
