import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_info/common/app_settings.dart';

class SharedPrefsAppSettings implements AppSettings {
  static const _countryIdKey  = 'country_id_key';
  static const _cityIdKey     = 'city_id_key';

  @override
  Future<int?> getCountryId() async {
    return _getInt(_countryIdKey);
  }

  @override
  Future<int?> getCityId() async {
    return _getInt(_cityIdKey);
  }

  Future<int?> _getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  @override
  Future<void> saveLocation(int countryId, int cityId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_countryIdKey, countryId);
    prefs.setInt(_cityIdKey, cityId);
  }
}