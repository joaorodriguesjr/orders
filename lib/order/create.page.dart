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

  final _order = Order();

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
                leading: const Icon(Icons.list_alt),
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

                    setState(() => _order.addItem(item));
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
                                  _order.items.remove(item.id);
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
              const Padding(padding: EdgeInsets.all(8)),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (_isValid)
                        ? () {
                            Navigator.pop(context, _order);
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
