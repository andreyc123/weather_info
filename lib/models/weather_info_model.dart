import 'package:weather_info/models/weather_day_model.dart';

class WeatherInfoModel {
  final List<WeatherDayModel> temperatureDays;
  final List<String> minTemperatures;
  final List<String> maxTemperatures;

  WeatherInfoModel({
    required this.temperatureDays,
    required this.minTemperatures,
    required this.maxTemperatures});
}