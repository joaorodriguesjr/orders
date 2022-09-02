import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/inventory.dart';

class FirestoreProducts implements ProductsQuery {
  final CollectionReference collection;

  FirestoreProducts(this.collection);

  @override
  Stream<List<Product>> allProducts() {
    return collection.orderBy('name').snapshots().map(productsFromSnapshot);
  }
}

List<Product> productsFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map(productFromDocument).toList();
}

Product productFromDocument(DocumentSnapshot doc) {
  var data = doc.data() as Map<String, dynamic>;
  return Product.restore(doc.id, data);
}
