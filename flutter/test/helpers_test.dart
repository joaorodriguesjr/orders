import 'package:flutter_test/flutter_test.dart';
import 'package:app/helpers.dart';

void main() {
  test('dates are localized to Brazilian Portuguese', () {
    var date = DateTime(2000, 1, 1);
    expect(dateFormat(date), 'sábado, 1 de janeiro');
  });
}
