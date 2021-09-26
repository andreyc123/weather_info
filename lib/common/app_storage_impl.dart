import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:weather_info/common/app_storage.dart';
import 'package:weather_info/models/country_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class _LocationsInput {
  final String json;
  final String locale;

  const _LocationsInput({
    required this.json,
    required this.locale
  });
}

List<CountryModel> _parseLocations(_LocationsInput input) {
  final parsed = jsonDecode(input.json).cast<Map<String, dynamic>>();
  return parsed.map<CountryModel>((json) => CountryModel.fromJson(json, input.locale)).toList();
}

class AppStorageImpl implements AppStorage {
  Future<String> _loadLocationsFrom(String filePath) {
    return rootBundle.loadString(filePath);
  }

  @override
  Future<List<CountryModel>> loadCountriesFromFile(
      String filePath,
      String locale) async {
    final json = await _loadLocationsFrom(filePath);
    return compute(_parseLocations, _LocationsInput(json: json, locale: locale));
  }
}