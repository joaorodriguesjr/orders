import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Currency extends StatelessWidget {
  final int value;

  final currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  Currency({Key? key, required this.value}) : super(key: key);

  @override
  Text build(BuildContext context) {
    return Text(currency.format(value));
  }
}
