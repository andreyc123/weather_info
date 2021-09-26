import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_info/utils/localization_utils.dart';
import 'base_location_model.dart';
import 'city_model.dart';
import 'package:collection/collection.dart';

class CountryModel extends BaseLocationModel {
  final String assetName;
  final List<CityModel> cities;

  const CountryModel({
    required int id,
    required String name,
    required this.assetName,
    required this.cities}) : super(id: id, name: name);

  factory CountryModel.fromJson(Map<String, dynamic> json, String locale) {
    final parsed = json['cities'].cast<Map<String, dynamic>>();
    final cities = parsed.map<CityModel>((json) => CityModel.fromJson(json, locale)).toList();
    return CountryModel(
        id: json['id'] as int,
        name: getLocalizedString(json['name'], locale),
        assetName: json['assetName'] as String,
        cities: cities
    );
  }

  CityModel? findCityById(int id) => cities.firstWhereOrNull((element) => element.id == id);

  AssetImage get assetImage => AssetImage('images/$assetName.png');
}