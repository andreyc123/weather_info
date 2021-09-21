import 'package:weather_info/utils/conversions.dart';

class ExtremeValueModel {
  final double value;
  final int year;

  String get temperatureAsString => value.toStringAsTemperature();
  String get rainfallAsString => value.toStringAsFixed2() + 'mm';
  String get yearAsString => year.toString();

  const ExtremeValueModel({required this.value, required this.year});

  factory ExtremeValueModel.fromRawString(String rawString) {
    double temperature = 0.0;
    int year = 0;
    var components = rawString.split(RegExp(r"\s*\("));
    if (components.length >= 2) {
      temperature = double.tryParse(components[0]) ?? 0.0;
      year = int.tryParse(components[1].replaceAll(')', '')) ?? 0;
    }
    return ExtremeValueModel(value: temperature, year: year);
  }

  @override
  String toString() {
    return 'temperature=$value year=$year';
  }
}