import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/products.dart';

class FirestoreProducts implements ProductsDataSource {
  final collection = FirebaseFirestore.instance.collection('items');

  @override
  Stream<List<Product>> all() {
    return collection.snapshots().map(productsFromSnapshot);
  }

  @override
  Future<void> createProduct(Product product) async {}

  @override
  Future<void> updateProduct(Product product) async {}

  @override
  Future<void> deleteProduct(Product product) async {}
}

List<Product> productsFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map(productFromDocument).toList();
}

Product productFromDocument(DocumentSnapshot doc) {
  var data = doc.data() as Map<String, dynamic>;

  return Product()
    ..id = doc.id
    ..description = data['description']
    ..price = data['price'];
}
