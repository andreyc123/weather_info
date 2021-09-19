import 'package:flutter/material.dart';
import 'package:weather_info/utils/dom_element.dart';
import 'package:html/dom.dart' as dom;
import 'package:weather_info/utils/conversions.dart';

class WeatherDayModel {
  final double min;
  final double max;
  final double average;
  final double deviation;
  final double rainfall;

  String get minAsString => min.toStringAsTemperature();
  String get maxAsString => max.toStringAsTemperature();
  String get averageAsString => average.toStringAsTemperature();

  String get deviationAsString {
    var result = deviation.toStringAsFixed2();
    if (deviation > 0) {
      result = '+' + result;
    }
    result += '°';
    return result;
  }

  Color get deviationColor {
    if (deviation > 1.0) {
      return Colors.red;
    }
    if (deviation < -1.0) {
      return Colors.blue;
    }
    return Colors.green;
  }

  bool get isRainfall => rainfall > 0.0;

  String get rainfallAsString => rainfall.toStringAsFixed2() + 'mm';

  static const int _minTemperatureIndex        = 1;
  static const int _maxTemperatureIndex        = 3;
  static const int _averageTemperatureIndex    = 2;
  static const int _deviationTemperatureIndex  = 4;
  static const int _rainfallIndex              = 5;

  const WeatherDayModel({
    required this.min,
    required this.max,
    required this.average,
    required this.deviation,
    required this.rainfall
  });

  factory WeatherDayModel.fromElements(List<dom.Element> elements) {
    return WeatherDayModel(
        min: elements[_minTemperatureIndex].doubleValue,
        max: elements[_maxTemperatureIndex].doubleValue,
        average: elements[_averageTemperatureIndex].doubleValue,
        deviation: elements[_deviationTemperatureIndex].doubleValue,
        rainfall: elements[_rainfallIndex].doubleValue);
  }

  @override
  String toString() {
    return 'min=$min max=$max average=$average ' +
        'deviation=$deviation rainfall=$rainfall';
  }

  static bool isDayEmpty({required List<dom.Element> elements}) {
    return elements[_minTemperatureIndex].text.isEmpty ||
        elements[_maxTemperatureIndex].text.isEmpty ||
        elements[_averageTemperatureIndex].text.isEmpty ||
        elements[_deviationTemperatureIndex].text.isEmpty ||
        elements[_rainfallIndex].text.isEmpty;
  }
}