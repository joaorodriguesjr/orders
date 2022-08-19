import 'package:android_intent_plus/android_intent.dart';
import 'package:delivery/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:app/helpers.dart';
import 'create_order.dart';
import 'order_details.dart';
import '../widgets/currency.dart';
import '../controllers.dart';

class ListOrdersView extends StatefulWidget {
  const ListOrdersView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListOrdersPageState();
}

class ListOrdersPageState extends State<ListOrdersView> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<OrdersController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => SystemNavigator.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: controller.ordersDay,
                firstDate:
                    controller.ordersDay.subtract(const Duration(days: 365)),
                lastDate: controller.ordersDay.add(const Duration(days: 365)),
              );

              if (date == null) return;

              controller.changeOrdersDay(date);
            },
          ),
          PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text('Gerar rota'),
                      onTap: () {
                        var addresses = Provider.of<OrdersController>(context,
                                listen: false)
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
                  ),
                ];
              }),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(dateFormat(controller.ordersDay),
                    style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          const Card(
            margin: EdgeInsets.all(8.0),
            child: OrdersList(),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 14.0)),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CreateOrderView(date: controller.ordersDay)),
          );
        },
        tooltip: 'Adicionar pedido',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OrdersController>(context);

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
                    OrderDetailsView(order: provider.orders[index]),
              ),
            );
          },
          onLongPress: () {
            var order = provider.orders[index];
            var snackBar = SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                  '${order.client.name} \n\n${order.address.description}. \n - ${order.address.complement} -'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

launchDeliveryRoute(List<Order> orders) {
  var route = '?daddr=';

  for (var order in orders) {
    route += '${order.address.description}+to:';
  }

  var query = Uri.encodeFull(route.substring(0, route.length - 4));

  AndroidIntent(
    action: 'action_view',
    package: 'com.google.android.apps.maps',
    data: 'http://maps.google.com/maps$query',
  ).launch();
}
