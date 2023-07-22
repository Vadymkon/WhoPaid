import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension DoubleExtension on double {
  String toStringAsFixedLength(int maxLength) {
    String value = toStringAsFixed(maxLength);
    while (value.length > 2 && value.endsWith('0')) {
      value = value.substring(0, value.length - 1);
    }
    if (value.endsWith('.')) {
      value = value.substring(0, value.length - 1);
    }
    return value;
  }
}


bool isPageOpen(BuildContext context, String path) {
  final currentRoute = ModalRoute.of(context)?.settings.name;
  return currentRoute == path;
}

double calculateSize(BuildContext context, dynamic value)
{
  double divider = (432/value);
  double vmin = MediaQuery.of(context).size.height < MediaQuery.of(context).size.width ? MediaQuery.of(context).size.height: MediaQuery.of(context).size.width;
  return vmin/divider;
}