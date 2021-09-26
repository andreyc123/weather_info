import 'dart:io';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:weather_info/api_client/weather_api_client.dart';
import 'package:weather_info/models/weather_day_model.dart';
import 'package:weather_info/models/weather_info_model.dart';
import 'package:weather_info/api_client/api_exceptions.dart';

class WeatherWebApiClient implements WeatherApiClient {
  static final String host = 'www.pogodaiklimat.ru';
  static final String monitorPath = 'monitor.php';

  static final cityIdParam  = 'id';
  static final monthParam   = 'month';
  static final yearParam    = 'year';

  static final int _monthTempRecordsTagIndex      = 0;
  static final int _monthRainfallRecordsTagIndex  = 1;
  static final int _maxTempTagIndex               = 2;
  static final int _minTempTagIndex               = 3;

  List<WeatherDayModel> _parseTemperatures(Document document) {
    List<WeatherDayModel> days = [];
    final climateDivs = document.getElementsByClassName('climate-table-wrap');
    if (climateDivs.isNotEmpty) {
      final tableTags = climateDivs[0].getElementsByTagName('table');
      if (tableTags.isNotEmpty) {
        final tableTag = tableTags[0];
        if (tableTag.children.isNotEmpty) {
          final bodyTag = tableTag.children[0];
          final trTags = bodyTag.children;
          if (trTags.length >= 3) {
            for (int trIndex = 2; trIndex < trTags.length; trIndex++) {
              final tdTags = trTags[trIndex].children;
              if (tdTags.length >= 6 && !WeatherDayModel.isDayEmpty(elements: tdTags)) {
                days.add(WeatherDayModel.fromElements(tdTags));
              }
            }
          }
        }
      }
    }
    return days;
  }

  List<String> _parseTemperaturesValues(Document document, int tempTagIndex) {
    List<String> days = [];
    final listsDivs = document.getElementsByClassName('top-list-biilet__lists');
    if (listsDivs.length >= tempTagIndex + 1) {
      final listsDiv = listsDivs[tempTagIndex];
      final ulTags = listsDiv.getElementsByClassName('values');
      if (ulTags.isNotEmpty) {
        final ulTag = ulTags[0];
        days = ulTag.children.map((e) => e.text).toList();
      }
    }
    return days;
  }

  Future<WeatherInfoModel> fetchData({required int cityId, int? month, int? year}) async {
    Map<String, String> queryParams = {};
    queryParams[cityIdParam] = cityId.toString();
    if (month != null) {
      queryParams[monthParam] = month.toString();
    }
    if (year != null) {
      queryParams[yearParam] = year.toString();
    }

    try {
      final requestUri = Uri.http(host, monitorPath, queryParams);
      final response = await http.get(requestUri);

      final statusCode = response.statusCode;
      if (statusCode != 200) {
        throw ServerApiException('Something went wrong (code=$statusCode)', statusCode);
      }

      final document = parse(response.body);
      return WeatherInfoModel(
          temperatureDays: _parseTemperatures(document),
          minTemperatures: _parseTemperaturesValues(document, _minTempTagIndex),
          maxTemperatures: _parseTemperaturesValues(document, _maxTempTagIndex),
          monthTempRecords: _parseTemperaturesValues(document, _monthTempRecordsTagIndex),
          monthRainfallRecords: _parseTemperaturesValues(document, _monthRainfallRecordsTagIndex));
    } on SocketException catch(_) {
      throw NetworkApiException('No Internet');
    } on HttpException catch(e) {
      throw NetworkApiException('Http error: $e.message');
    }
  }
}