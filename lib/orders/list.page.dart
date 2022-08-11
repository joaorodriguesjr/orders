import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
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
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String format() {
      initializeDateFormatting('pt_BR', null);
      return DateFormat.MMMMEEEEd('pt_BR').format(_date);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pedidos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(2020),
                lastDate: DateTime(2025),
              );

              if (date == null) return;

              setState(() {
                _date = date;
              });
            },
          ),
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
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(format(), style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          Card(margin: const EdgeInsets.all(16.0), child: _orders()),
          const Padding(padding: EdgeInsets.symmetric(vertical: 14.0)),
        ],
      )),
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
        primary: false,
        itemCount: provider.orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.inventory_outlined),
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
