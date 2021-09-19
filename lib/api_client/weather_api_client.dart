import 'package:weather_info/models/weather_info_model.dart';

abstract class WeatherApiClient {
  Future<WeatherInfoModel> fetchData({required int cityId, int? month, int? year});
}