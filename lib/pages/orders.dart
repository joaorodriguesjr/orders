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
        title: const Text('Orders'),
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
      body: const Center(child: Text('Orders')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add Order',
        child: const Icon(Icons.add),
      ),
    );
  }
}
