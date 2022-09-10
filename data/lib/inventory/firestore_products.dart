import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/inventory.dart';

class FirestoreProducts implements ProductsQuery, ProductsPersistence {
  final CollectionReference collection;

  FirestoreProducts(this.collection);

  @override
  Stream<List<Product>> allProducts() {
    return collection.orderBy('name').snapshots().map(productsFromSnapshot);
  }

  @override
  Future<Product?> findByCode(String code) async {
    final doc = await collection.doc(code).get();
    return (doc.exists) ? productFromDocument(doc) : null;
  }

  @override
  Future<void> persist(Product product) async {
    collection
        .doc(product.code)
        .set({'name': product.name, 'description': product.description});
  }
}

List<Product> productsFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map(productFromDocument).toList();
}

Product productFromDocument(DocumentSnapshot doc) {
  var data = doc.data() as Map<String, dynamic>;
  return Product.restore(doc.id, data);
}
