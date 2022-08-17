import 'models.dart';

abstract class ClientsDataSource {
  Stream<List<Client>> all();

  Future<void> createClient(Client client);
  Future<void> updateClient(Client client);
  Future<void> deleteClient(Client client);
}
