import 'package:weather_info/models/country_model.dart';

abstract class AppStorage {
  Future<List<CountryModel>> loadCountriesFromFile(
      String filePath,
      String locale);
}