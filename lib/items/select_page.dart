import 'package:flutter/material.dart';
import 'package:orders/items/provider.dart';
import 'package:provider/provider.dart';

class SelectItemPage extends StatefulWidget {
  const SelectItemPage({Key? key}) : super(key: key);

  @override
  State<SelectItemPage> createState() => _SelectItemPageState();
}

class _SelectItemPageState extends State<SelectItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar item'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Card(
        child: _items(),
      ),
    );
  }

  Widget _items() {
    return Consumer<ItemsProvider>(builder: (context, provider, _) {
      var items = provider.items;

      return ListView.separated(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(items[index].description),
          trailing: Text(items[index].price.toString()),
          onTap: () => Navigator.pop(context, items[index]),
        ),
        separatorBuilder: (context, index) => const Divider(),
      );
    });
  }
}
