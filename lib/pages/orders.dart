import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OrdersPageState();
}

class OrdersPageState extends State<OrdersPage> {
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
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(child: Text('Pedidos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Adicionar pedido',
        child: const Icon(Icons.add),
      ),
    );
  }
}
