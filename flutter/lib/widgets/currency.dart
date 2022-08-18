import 'package:flutter/widgets.dart';
import 'package:app/helpers.dart';

class Currency extends StatelessWidget {
  final int value;

  const Currency({Key? key, required this.value}) : super(key: key);

  @override
  Text build(BuildContext context) {
    return Text(currencyFormat(value));
  }
}
