import 'package:flutter/material.dart';
import 'package:weather_info/common/app_storage.dart';
import 'package:weather_info/models/city_model.dart';
import 'package:weather_info/models/country_model.dart';
import 'package:collection/collection.dart';

class LocationsModel extends ChangeNotifier {
  final AppStorage appStorage;
  List<CountryModel>? _countries;

  LocationsModel({required this.appStorage});

  bool get hasData => _countries != null;

  List<CountryModel> get countries => _countries ?? [];

  set countries(List<CountryModel> newCountries) {
    _countries = newCountries;
    notifyListeners();
  }

  CountryModel? findCountryById(int countryId) =>
      countries.firstWhereOrNull((element) => element.id == countryId);

  String? findLocationNameBy(int countryId, int cityId) {
    var country = findCountryById(countryId);
    if (country != null) {
      var city = country.findCityById(cityId);
      if (city != null) {
        return '${city.name}, ${country.name}';
      }
    }
    return null;
  }

  List<CityModel> findAllCitiesById(int countryId) =>
      findCountryById(countryId)?.cities ?? [];

  void readData({required String locale}) async {
    countries = await appStorage.loadCountriesFromFile(
        'assets/locations.json',
        locale);
  }
}
