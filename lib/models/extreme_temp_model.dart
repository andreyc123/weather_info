import 'package:weather_info/utils/conversions.dart';

class ExtremeTemperatureModel {
  final double temperature;
  final int year;

  String get temperatureAsString => temperature.toStringAsTemperature();
  String get yearAsString => year.toString();

  const ExtremeTemperatureModel({required this.temperature, required this.year});

  factory ExtremeTemperatureModel.fromRawString(String rawString) {
    double temperature = 0.0;
    int year = 0;
    var components = rawString.split(RegExp(r"\s*\("));
    if (components.length >= 2) {
      temperature = double.tryParse(components[0]) ?? 0.0;
      year = int.tryParse(components[1].replaceAll(')', '')) ?? 0;
    }
    return ExtremeTemperatureModel(temperature: temperature, year: year);
  }

  @override
  String toString() {
    return 'temperature=$temperature year=$year';
  }
}