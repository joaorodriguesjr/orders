class Address {
  String description = '';
  String complement = '';
}

class Client {
  String id = '';
  String name = '';
  String phone = '';
  Address address = Address();

  Client() {}

  factory Client.restore(String id, Map<String, dynamic> data) {
    return Client()
      ..id = id
      ..name = data['name']
      ..phone = data['phone']
      ..address.description = data['address']['description']
      ..address.complement = data['address']['complement'];
  }

  Map<String, dynamic> data() {
    return {
      'name': this.name,
      'phone': this.phone,
      'address': {
        'description': this.address.description,
        'complement': this.address.complement,
      },
    };
  }
}
