import 'record.dart';

abstract class RecordsPersistence {
  Future<void> persist(Record record);
}
