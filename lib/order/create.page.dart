import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orders/client/select.page.dart';
import 'package:orders/clients/model.dart';
import 'package:orders/orders/model.dart';

import '../item/select.page.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  var _client = Client()
    ..name = 'Cliente. . .'
    ..address.description = '. . .';

  final _order = Order()
    ..payment.kind = 'PIX'
    ..payment.status = 'A RECEBER';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Pedido'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(padding: EdgeInsets.all(8)),
              _clientSelection(),
              const Padding(padding: EdgeInsets.all(8), child: Divider()),
              ListTile(
                title: const Text('Items do Pedido'),
                leading: const Icon(Icons.format_list_numbered),
                trailing: IconButton(
                  onPressed: () async {
                    var item = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectItemPage(),
                      ),
                    );

                    if (item == null) {
                      return;
                    }

                    setState(() => _order.add(item));
                  },
                  icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                ),
              ),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Item')),
                  DataColumn(label: Text('Quantidade')),
                ],
                rows: _order.items.values.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(
                          Expanded(flex: 2, child: Text(item.description))),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (item.quantity > 1) {
                                  setState(() => item.decreaseQuantity());
                                } else {
                                  _order.remove(item.id);
                                }
                              });
                            },
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() => item.increaseQuantity());
                            },
                          ),
                        ],
                      )),
                    ],
                  );
                }).toList(),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                              groupValue: _order.payment.kind,
                              value: 'PIX',
                              onChanged: (value) {
                                setState(() =>
                                    _order.payment.kind = value as String);
                              }),
                          const Text('Pix'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              groupValue: _order.payment.kind,
                              value: 'DINHEIRO',
                              onChanged: (value) {
                                setState(() =>
                                    _order.payment.kind = value as String);
                              }),
                          const Text('Dinheiro'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              groupValue: _order.payment.kind,
                              value: 'CARTAO',
                              onChanged: (value) {
                                setState(() =>
                                    _order.payment.kind = value as String);
                              }),
                          const Text('Cartão'),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                              groupValue: _order.payment.status,
                              value: 'PAGO',
                              onChanged: (value) {
                                setState(() =>
                                    _order.payment.status = value as String);
                              }),
                          const Text('Recebido'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              groupValue: _order.payment.status,
                              value: 'A RECEBER',
                              onChanged: (value) {
                                setState(() =>
                                    _order.payment.status = value as String);
                              }),
                          const Text('A Receber'),
                        ],
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(right: 0.0)),
                ],
              ),
              const Padding(padding: EdgeInsets.all(8)),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (_isValid)
                        ? () async {
                            // FIXME: implement the save logic on a provider
                            var data = {
                              'client': {
                                'id': _client.id,
                                'name': _client.name
                              },
                              'address': {
                                'description': _client.address.description,
                                'complement': _client.address.complement,
                              },
                              'datetime': Timestamp.now(),
                              'items': {
                                for (var item in _order.items.values)
                                  item.id: {
                                    'description': item.description,
                                    'price': item.price,
                                    'quantity': item.quantity,
                                  }
                              },
                              'payment': {
                                'kind': _order.payment.kind,
                                'status': _order.payment.status,
                              },
                            };

                            await FirebaseFirestore.instance
                                .collection('orders')
                                .doc()
                                .set(data);

                            Navigator.pop(context);
                          }
                        : null,
                    child: const Text('SALVAR'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool get _isValid => _client.id.isNotEmpty && _order.items.isNotEmpty;

  Widget _clientSelection() {
    return ListTile(
      title: Text(_client.name),
      subtitle: Text(_client.address.description),
      leading: const Icon(Icons.person),
      trailing: IconButton(
        icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
        onPressed: () async {
          var client = await Navigator.push<Client>(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectClientPage(),
            ),
          );

          if (client == null) {
            return;
          }

          setState(() => _client = client);
        },
      ),
    );
  }
}
