import 'package:intl/intl.dart';

extension NumberConversion on double {
  String toStringAsFixed2() {
    NumberFormat formatter = NumberFormat();
    formatter.minimumFractionDigits = 1;
    formatter.maximumFractionDigits = 2;
    return formatter.format(this);
  }

  String toStringAsTemperature() {
    return toStringAsFixed2() + '°';
  }
}