import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:orders/orders/model.dart';
import 'package:orders/shared/currency.dart';

class OrderDetailsPage extends StatefulWidget {
  final Order order;
  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var order = widget.order;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Pedido'),
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
            leading: const Icon(Icons.location_on),
            title: Text(order.address.description,
                softWrap: false, overflow: TextOverflow.fade),
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
            title: const Text('+00 (00) 00000-0000'),
            subtitle: const Text('Enviar mensagem via WhatsApp'),
            onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          _items(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.black54),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.print, color: Colors.black54),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ))),
    );
  }

  Widget _items() {
    var entries = widget.order.items.entries;
    List<Widget> rows = [];

    for (var item in entries) {
      var row = Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${item.value.quantity}'),
            Text(item.value.description),
            Currency(value: item.value.quantity * item.value.price),
          ],
        ),
      );

      rows.add(row);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(children: rows),
    );
  }
}