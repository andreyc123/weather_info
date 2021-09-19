import 'package:flutter/material.dart';
import 'package:weather_info/models/city_model.dart';
import 'package:weather_info/models/country_model.dart';
import 'package:collection/collection.dart';
import 'package:weather_info/utils/locations_localization.dart';

class LocationsModel {
  static List<CountryModel> _countries = [
    CountryModel(
        id: 1000,
        name: 'ukraine',
        assetName: 'ukraine-flag-square-xs',
        cities: [
          CityModel(id: 33345, name: 'kyiv'),
          CityModel(id: 34300, name: 'kharkiv'),
          CityModel(id: 33562, name: 'vinnytsia'),
          CityModel(id: 33910, name: "heniches_k"),
          CityModel(id: 34504, name: 'dnipro'),
          CityModel(id: 34601, name: 'zaporizhzhia'),
          CityModel(id: 33526, name: 'ivanoFrankivsk'),
          CityModel(id: 33889, name: 'izmail'),
          CityModel(id: 33261, name: 'konotop'),
          CityModel(id: 33791, name: 'kryvyi_Rih'),
          CityModel(id: 33711, name: 'kropyvnytskyi'),
          CityModel(id: 33393, name: 'lviv'),
          CityModel(id: 34712, name: "mariupol"),
          CityModel(id: 33837, name: 'odesa'),
          CityModel(id: 33506, name: 'poltava'),
          CityModel(id: 33301, name: 'rivne'),
          CityModel(id: 33631, name: 'uzhhorod'),
          CityModel(id: 33902, name: 'kherson'),
          CityModel(id: 33135, name: 'chernihiv'),
          CityModel(id: 33658, name: 'chernivtsi')
        ]),
    CountryModel(
        id: 1001,
        name: 'russia',
        assetName: 'russia-flag-square-xs',
        cities: [
          CityModel(id: 27612, name: 'moscow'),
          CityModel(id: 26063, name: 'saintPetersburg'),
          CityModel(id: 29638, name: 'novosibirsk')
        ])
  ];

  List<CountryModel> get countries => _countries;

  CountryModel? findCountryById(int countryId) =>
      _countries.firstWhereOrNull((element) => element.id == countryId);

  String? findLocationNameBy(BuildContext context, int countryId, int cityId) {
    var country = findCountryById(countryId);
    if (country != null) {
      var city = country.findCityById(cityId);
      if (city != null) {
        final localizedCityName = LocationsLocalization.getCityName(context, city.name);
        final localizedCountryName = LocationsLocalization.getCountryName(context, country.name);
        return '$localizedCityName, $localizedCountryName';
      }
    }
    return null;
  }

  List<CityModel> findAllCitiesById(int countryId) =>
      findCountryById(countryId)?.cities ?? [];
}
