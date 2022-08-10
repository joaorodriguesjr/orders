import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:orders/order/create.page.dart';
import 'package:orders/order/details.page.dart';
import 'package:orders/orders/provider.dart';
import 'package:orders/shared/currency.dart';
import 'package:provider/provider.dart';

class ListOrdersPage extends StatefulWidget {
  const ListOrdersPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListOrdersPageState();
}

class ListOrdersPageState extends State<ListOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        leading: IconButton(
          icon: const Icon(Icons.article),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              var addresses =
                  Provider.of<OrdersProvider>(context, listen: false)
                      .orders
                      .map((order) => order.address.description)
                      .toList();

              var route = '?daddr=';

              for (var address in addresses) {
                route += '$address+to:';
              }

              AndroidIntent(
                action: 'action_view',
                package: 'com.google.android.apps.maps',
                data:
                    'http://maps.google.com/maps${Uri.encodeFull(route.substring(0, route.length - 4))}',
              ).launch();
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(child: Card(child: _orders())),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateOrderPage()),
          );
        },
        tooltip: 'Adicionar pedido',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _orders() {
    return Consumer<OrdersProvider>(builder: (context, provider, child) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: provider.orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(provider.orders[index].client.name),
            subtitle: Text(
              provider.orders[index].address.description,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
            trailing: Currency(value: provider.orders[index].total),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      OrderDetailsPage(order: provider.orders[index]),
                ),
              );
            },
            onLongPress: () {
              var order = provider.orders[index];
              var snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                    '${order.client.name} \n\n ${order.address.description}. \n - ${order.address.complement} -'),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      );
    });
  }
}
