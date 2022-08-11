import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:orders/orders/model.dart';
import 'package:orders/shared/currency.dart';
import 'package:orders/orders/provider.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatefulWidget {
  final Order order;
  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
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
              printer.invokeMethod('print', {'text': _ticket()});
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              AndroidIntent(
                package: 'com.whatsapp',
                action: 'action_view',
                data: Uri.encodeFull(
                    'https://api.whatsapp.com/send?phone=5531993390417&text=${_confirmation()}'),
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
                    leading: const Icon(Icons.location_on),
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
                    title: const Text('+00 (00) 00000-0000'),
                    subtitle: const Text('Enviar mensagem via WhatsApp'),
                    onTap: () {
                      AndroidIntent(
                        package: 'com.whatsapp',
                        action: 'action_view',
                        data: Uri.encodeFull(
                            'https://api.whatsapp.com/send?phone=0000000000000'),
                      ).launch();
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  _items(),
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
                              Radio(
                                  groupValue: order.payment.kind,
                                  value: 'PIX',
                                  onChanged: (value) {
                                    setState(() =>
                                        order.payment.kind = value as String);
                                  }),
                              const Text('Pix'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  groupValue: order.payment.kind,
                                  value: 'DINHEIRO',
                                  onChanged: (value) {
                                    setState(() =>
                                        order.payment.kind = value as String);
                                  }),
                              const Text('Dinheiro'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  groupValue: order.payment.kind,
                                  value: 'CARTAO',
                                  onChanged: (value) {
                                    setState(() =>
                                        order.payment.kind = value as String);
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
                                  groupValue: order.payment.status,
                                  value: 'PAGO',
                                  onChanged: (value) {
                                    setState(() =>
                                        order.payment.status = value as String);
                                  }),
                              const Text('Recebido'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  groupValue: order.payment.status,
                                  value: 'A RECEBER',
                                  onChanged: (value) {
                                    setState(() =>
                                        order.payment.status = value as String);
                                  }),
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
                        onPressed: () async {},
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
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                ),
                                TextButton(
                                  child: const Text('Excluir'),
                                  onPressed: () {
                                    Provider.of<OrdersProvider>(context,
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

  String _ticket() {
    initializeDateFormatting('pt_BR');
    var datetime = DateFormat.yMMMMd('pt_BR').format(DateTime.now());
    var ticket = '' +
        "[C]<font size='tall'>Familia Delivery</font>\n\n" +
        "[C]${datetime}\n\n" +
        "[L]Cliente: [R]${widget.order.client.name}\n" +
        "[L]${widget.order.address.description}.   ${widget.order.address.complement}\n" +
        "--------------------------------\n" +
        "";

    for (var item in widget.order.items.entries) {
      ticket +=
          "[L]${item.value.quantity}x ${item.value.description} [R]R\$${item.value.quantity * item.value.price},00\n";
    }

    ticket += "\n" +
        "[R]<b>Total</b> R\$${widget.order.total},00\n" +
        "--------------------------------\n" +
        "[L]Pagamento: [R]${widget.order.payment.kind}\n" +
        "\n[C]<font size='big'>${widget.order.payment.status}</font>\n\n" +
        "[C]Obrigado pela \n[C]preferencia!!!\n";

    return ticket;
  }

  String _confirmation() {
    initializeDateFormatting('pt_BR');
    var datetime = DateFormat.yMMMMd('pt_BR').format(DateTime.now());
    var message = '' +
        "*Familia Delivery*\n\n" +
        "${datetime}\n\n" +
        "${widget.order.client.name}\n" +
        "${widget.order.address.description}. [ *${widget.order.address.complement}* ]\n" +
        "\n\n";

    for (var item in widget.order.items.entries) {
      message +=
          "```${item.value.quantity}x ${item.value.description} R\$${item.value.quantity * item.value.price},00```\n";
    }
    message += "\n" +
        "```Total R\$${widget.order.total},00```\n\n" +
        "\nPagamento:  ${widget.order.payment.kind}  *${widget.order.payment.status}*\n" +
        "";
    return message;
  }
}
