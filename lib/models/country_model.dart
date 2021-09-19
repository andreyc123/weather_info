import 'package:flutter/material.dart';
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

  CityModel? findCityById(int id) => cities.firstWhereOrNull((element) => element.id == id);

  AssetImage get assetImage => AssetImage('images/$assetName.png');
}