import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

export './repositories/products.dart';
export './repositories/firestore_products.dart';

class Repository {
  static Type of<Type>(BuildContext context) => Provider.of<Type>(context);
}
