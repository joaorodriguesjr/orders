import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/inventory.dart';

class FirestoreRecords implements RecordsPersistence {
  final CollectionReference collection;

  FirestoreRecords(this.collection);

  @override
  Future<void> persist(Record record) async {
    final product =
        collection.firestore.collection('/products').doc(record.product.code);

    collection.doc().set({
      'moment': record.moment,
      'price': record.price,
      'quantity': record.quantity,
      'product': product,
    });
  }
}
