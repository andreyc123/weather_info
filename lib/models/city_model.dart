import 'package:weather_info/utils/localization_utils.dart';
import 'base_location_model.dart';

class CityModel extends BaseLocationModel {
  const CityModel({required int id, required String name})
      : super(id: id, name: name);

  factory CityModel.fromJson(Map<String, dynamic> json, String locale) {
    return CityModel(
        id: json['id'] as int,
        name: getLocalizedString(json['name'], locale)
    );
  }
}