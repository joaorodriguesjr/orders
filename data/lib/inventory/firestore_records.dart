import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/inventory.dart';

class FirestoreRecords implements RecordsPersistence {
  final CollectionReference records;

  final CollectionReference products;

  FirestoreRecords(this.records, this.products);

  @override
  Future<void> persist(Record record) async {
    final product = products.doc(record.product.code);

    records.doc().set({
      'moment': record.moment,
      'price': record.price,
      'quantity': record.quantity,
      'product': product,
    });
  }
}
