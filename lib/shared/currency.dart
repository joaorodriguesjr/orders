import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Currency extends StatelessWidget {
  final int value;

  final currency = NumberFormat('R\$#,##0.00', 'pt_BR');

  Currency({Key? key, required this.value}) : super(key: key);

  @override
  Text build(BuildContext context) {
    return Text(currency.format(value));
  }
}
