import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:delivery/orders.dart';
import 'package:provider/provider.dart';

import 'package:app/helpers.dart';
import 'update_order.dart';
import '../widgets/currency.dart';
import '../controllers.dart';

class OrderDetailsView extends StatefulWidget {
  final Order order;
  const OrderDetailsView({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailsView> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsView> {
  static const printer = MethodChannel('delivery.printer');

  @override
  Widget build(BuildContext context) {
    var order = widget.order;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Pedido'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              printer.invokeMethod('print', {'text': ticket(order)});
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              AndroidIntent(
                package: 'com.whatsapp',
                action: 'action_view',
                data: Uri.encodeFull(
                    'https://api.whatsapp.com/send?phone=${order.client.phone}&text=${confirmation(order)}'),
              ).launch();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
                    child: Text(
                      order.client.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Text(order.address.description,
                    softWrap: false, overflow: TextOverflow.ellipsis),
                subtitle: const Text('Visualizar no mapa'),
                onTap: () {
                  AndroidIntent(
                    action: 'action_view',
                    package: 'com.google.android.apps.maps',
                    data:
                        'http://maps.google.com/maps?daddr=${Uri.encodeFull(order.address.description)}',
                  ).launch();
                },
              ),
              ListTile(
                leading: const Icon(Icons.whatsapp),
                title: Text(order.client.phone),
                subtitle: const Text('Enviar mensagem via WhatsApp'),
                onTap: () {
                  AndroidIntent(
                    package: 'com.whatsapp',
                    action: 'action_view',
                    data: Uri.encodeFull(
                        'https://api.whatsapp.com/send?phone=${order.client.phone}'),
                  ).launch();
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              OrderItems(order: order),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 16.0),
                        child: const Text('Total')),
                    Currency(value: order.total),
                  ],
                ),
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
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                            child: (order.payment.kind != 'PIX')
                                ? const Icon(Icons.check_box_outline_blank,
                                    color: Colors.white)
                                : const Icon(Icons.check_circle_outline,
                                    color: Colors.black45),
                          ),
                          const Text('Pix'),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                            child: (order.payment.kind != 'DINHEIRO')
                                ? const Icon(Icons.check_box_outline_blank,
                                    color: Colors.white)
                                : const Icon(Icons.check_circle_outline,
                                    color: Colors.black45),
                          ),
                          const Text('Dinheiro'),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                            child: (order.payment.kind != 'CARTAO')
                                ? const Icon(Icons.check_box_outline_blank,
                                    color: Colors.white)
                                : const Icon(Icons.check_circle_outline,
                                    color: Colors.black45),
                          ),
                          const Text('Cartão'),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                            child: (order.payment.status != 'PAGO')
                                ? const Icon(Icons.check_box_outline_blank,
                                    color: Colors.white)
                                : const Icon(Icons.check_circle_outline,
                                    color: Colors.black45),
                          ),
                          const Text('Recebido'),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                            child: (order.payment.status != 'A RECEBER')
                                ? const Icon(Icons.check_box_outline_blank,
                                    color: Colors.white)
                                : const Icon(Icons.check_circle_outline,
                                    color: Colors.black45),
                          ),
                          const Text('A Receber'),
                        ],
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(right: 0.0)),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: const Text('EDITAR'),
                    onPressed: () async {
                      var updatedOrder = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateOrderView(order: order),
                        ),
                      );

                      if (updatedOrder == null) return;

                      setState(() {
                        order = updatedOrder as Order;
                      });
                    },
                  ),
                  TextButton(
                    child: const Text('EXCLUIR'),
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      var delete = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Excluir Pedido'),
                          content: const Text(
                              'A exclusão é uma ação permanente. Deseja realmente excluir o pedido?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () => Navigator.pop(context, false),
                            ),
                            TextButton(
                              child: const Text('Excluir'),
                              onPressed: () {
                                Provider.of<OrdersController>(context,
                                        listen: false)
                                    .deleteOrder(order);
                                Navigator.pop(context, true);
                              },
                            ),
                          ],
                        ),
                      );

                      if (delete) navigator.pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItems extends StatelessWidget {
  final Order order;

  const OrderItems({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];

    order.items.forEach((id, item) {
      var row = Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${item.quantity}'),
            Text(item.product.description),
            Currency(value: item.quantity * item.product.price),
          ],
        ),
      );

      rows.add(row);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(children: rows),
    );
  }
}
