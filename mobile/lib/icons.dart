import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/widgets.dart';

class CustomIcons {
  CustomIcons._();

  static const String _fontFamily = 'inventory';

  static const IconData inventory_in =
      IconData(0xe900, fontFamily: _fontFamily);
  static const IconData inventory_ou =
      IconData(0xe901, fontFamily: _fontFamily);

  static const IconData package_plus = MdiIcons.packageVariantPlus;
}
