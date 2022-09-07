import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<String> barcodeScan() async {
  return FlutterBarcodeScanner.scanBarcode(
      '#ff6666', 'Cancelar', false, ScanMode.DEFAULT);
}
