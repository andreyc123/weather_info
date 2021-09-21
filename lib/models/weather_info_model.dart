import 'package:weather_info/models/weather_day_model.dart';
import 'extreme_temp_model.dart';

class WeatherRecordModel {
  final ExtremeValueModel min;
  final ExtremeValueModel max;

  const WeatherRecordModel({
    required this.min,
    required this.max});
}

class WeatherInfoModel {
  final List<WeatherDayModel> temperatureDays;
  final List<String> minTemperatures;
  final List<String> maxTemperatures;
  final List<String> monthTempRecords;
  final List<String> monthRainfallRecords;

  const WeatherInfoModel({
    required this.temperatureDays,
    required this.minTemperatures,
    required this.maxTemperatures,
    required this.monthTempRecords,
    required this.monthRainfallRecords});

  WeatherRecordModel? get monthTempRecord {
    if (monthTempRecords.length >= 2) {
      return WeatherRecordModel(
          min: ExtremeValueModel.fromRawString(monthTempRecords[1]),
          max: ExtremeValueModel.fromRawString(monthTempRecords[0])
      );
    }
    return null;
  }

  WeatherRecordModel? get monthRainfallRecord {
    if (monthRainfallRecords.length >= 2) {
      return WeatherRecordModel(
          min: ExtremeValueModel.fromRawString(monthRainfallRecords[1]),
          max: ExtremeValueModel.fromRawString(monthRainfallRecords[0])
      );
    }
    return null;
  }
}