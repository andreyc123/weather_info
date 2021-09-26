import 'package:flutter/material.dart';
import 'package:weather_info/models/city_model.dart';
import 'locations_model.dart';

class SelectCityModel extends ChangeNotifier {
  final int selectedCountryId;
  var _filterSelected = false;
  String? _filterText;
  List<CityModel> _originCities = [];
  List<CityModel> _filteredCities = [];
  late LocationsModel _locations;

  SelectCityModel({required this.selectedCountryId});

  bool get isFilterSelected => _filterSelected;
  String get filterText => _filterText ?? '';

  List<CityModel> get filteredCities =>
      _filterText != null ? _filteredCities : originCities;

  List<CityModel> get originCities {
    if (_originCities.isEmpty) {
      _originCities = _locations.findCountryById(selectedCountryId)?.cities ?? [];
    }
    return _originCities;
  }

  set isFilterSelected(bool filterSelected) {
    _filterSelected = filterSelected;
    notifyListeners();
  }

  set locations(LocationsModel newLocations) {
    _locations = newLocations;
    notifyListeners();
  }

  void toggleFilter() {
    _filterSelected = !_filterSelected;
    if (_filterSelected) {
      changeFilterText(filterText);
    } else {
      changeFilterText('');
    }
  }

  void changeFilterText(String newFilterText) {
    _filterText = newFilterText;
    if (newFilterText.isEmpty) {
      _filteredCities = originCities;
    } else {
      final f = newFilterText.toLowerCase();
      _filteredCities = originCities.where((element) =>
          element.name.toLowerCase().startsWith(f)).toList();
    }
    notifyListeners();
  }
}