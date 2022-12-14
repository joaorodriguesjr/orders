import 'package:flutter/material.dart';
import 'package:delivery/clients.dart';
import 'package:delivery/orders.dart';
import 'package:provider/provider.dart';

import '../controllers.dart';
import 'select_client.dart';
import 'select_product.dart';

class CreateOrderView extends StatefulWidget {
  final DateTime date;

  const CreateOrderView({Key? key, required this.date}) : super(key: key);

  @override
  State<CreateOrderView> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderView> {
  var _client = Client()..name = 'Cliente';

  final _order = Order();

  @override
  void initState() {
    _order.datetime = widget.date;
    _order.payment.kind = 'PIX';
    _order.payment.status = 'A RECEBER';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    var controller = Provider.of<OrdersController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Pedido'),
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
          margin: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(padding: EdgeInsets.all(8)),
              _ClientSelection(
                client: _client,
                onClientChange: (Client client) {
                  setState(() {
                    _client = client;
                    _order.client = client;
                    _order.address = client.address;
                  });
                },
              ),
              const Padding(padding: EdgeInsets.all(8), child: Divider()),
              ListTile(
                title: const Text('Items do Pedido'),
                leading: const Icon(Icons.inventory_outlined),
                trailing: IconButton(
                  onPressed: () async {
                    var item = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectProductView(),
                      ),
                    );

                    if (item == null) {
                      return;
                    }

                    setState(() => _order.add(item));
                  },
                  icon: Icon(Icons.add_circle_outline,
                      color: Theme.of(context).primaryColor),
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
                      DataCell(Text(item.product.description)),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (item.quantity > 1) {
                                  setState(() => item.decreaseQuantity());
                                } else {
                                  _order.remove(item.product.id);
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
              const Padding(padding: EdgeInsets.all(8), child: Divider()),
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
                          const Text('Cart??o'),
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
                            await controller.registerOrder(_order);
                            navigator.pop();
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

  bool get _isValid {
    return _client.id.isNotEmpty && _order.items.isNotEmpty;
  }
}

class _ClientSelection extends StatelessWidget {
  final Client client;

  final Function(Client client) onClientChange;

  const _ClientSelection(
      {Key? key, required this.client, required this.onClientChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(client.name),
      subtitle: (client.address.description.isNotEmpty)
          ? Text(client.address.description)
          : null,
      leading: const Icon(Icons.person_outline),
      trailing: IconButton(
        icon: Icon(Icons.add_circle_outline,
            color: Theme.of(context).primaryColor),
        onPressed: () async {
          var client = await Navigator.push<Client>(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectClientView(),
            ),
          );

          if (client == null) {
            return;
          }

          onClientChange(client);
        },
      ),
    );
  }
}
