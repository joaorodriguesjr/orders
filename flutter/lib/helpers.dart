import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:delivery/orders/models.dart';

String dateFormat(DateTime datetime) {
  initializeDateFormatting('pt_BR', null);
  return DateFormat.MMMMEEEEd('pt_BR').format(datetime);
}

String currencyFormat(value) {
  var currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  return currency.format(value);
}

String ticket(Order order) {
  var items = '';

  order.items.forEach((id, item) {
    items +=
        '[L]${item.quantity}x ${item.product.description} [R]${currencyFormat(item.quantity * item.product.price)}\n';
  });

  return """
[C]<font size='tall'>Família Delivery</font>

[C] ${dateFormat(order.datetime)}

[L]Cliente: [R]${order.client.name}
[L]${order.address.description}.   ${order.address.complement}
--------------------------------
$items

[R]<b>Total</b> ${currencyFormat(order.total)}
--------------------------------
[L]Pagamento: [R]${order.payment.kind}

[C]<font size='big'>${order.payment.status}</font>

[C]Obrigado\n[C]pela prefêrencia!!!

""";
}

String confirmation(Order order) {
  var items = '';

  order.items.forEach((id, item) {
    items +=
        '```${item.quantity}x ${item.product.description} ${currencyFormat(item.quantity * item.product.price)}```\n';
  });

  return """
*Família Delivery*

${dateFormat(order.datetime)}

${order.client.name}
${order.address.description}. [ *${order.address.complement}* ]

$items

```Total ${currencyFormat(order.total)}```


Pagamento:  ${order.payment.kind}  *${order.payment.status}*

""";
}
