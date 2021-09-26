import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather_info/api_client/api_exceptions.dart';
import 'package:weather_info/api_client/weather_api_client.dart';
import 'package:weather_info/common/app_settings.dart';
import 'package:weather_info/models/locations_model.dart';
import 'package:weather_info/models/weather_day_model.dart';
import 'package:weather_info/models/weather_info_model.dart';
import 'package:weather_info/models/extreme_temp_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_info/utils/string_utils.dart';

enum WeatherApiStatus { loaded, loading, error }

class HomeModel extends ChangeNotifier {
  final WeatherApiClient apiClient;
  final AppSettings appSettings;
  ApiException? _apiException;
  WeatherInfoModel? _weatherInfo;
  WeatherApiStatus _apiStatus = WeatherApiStatus.loaded;
  int? _selectedCountryId;
  int? _selectedCityId;
  int? _selectedMonth;
  int? _selectedYear;
  late LocationsModel _locations;

  HomeModel({
    required this.apiClient,
    required this.appSettings}) {
    _handleAppStart();
  }

  set locations(LocationsModel newLocations) {
    _locations = newLocations;
    notifyListeners();
  }

  bool get hasData => _weatherInfo != null;
  WeatherApiStatus get apiStatus => _apiStatus;
  String? get apiErrorMessage => _apiException?.message;

  List<WeatherDayModel> get temperatureDays => _weatherInfo?.temperatureDays ?? [];
  List<ExtremeValueModel> get minTemperatures =>
      (_weatherInfo?.minTemperatures ?? []).map((e) => ExtremeValueModel.fromRawString(e)).toList();
  List<ExtremeValueModel> get maxTemperatures =>
      (_weatherInfo?.maxTemperatures ?? []).map((e) => ExtremeValueModel.fromRawString(e)).toList();

  DateTime? get selectedDate {
    if (_selectedMonth != null || _selectedYear != null) {
      return DateTime(_selectedYear!, _selectedMonth!);
    }
    return null;
  }

  int? get selectedCountryId => _selectedCountryId;
  int? get selectedCityId => _selectedCityId;

  WeatherRecordModel? get monthTempRecord => _weatherInfo?.monthTempRecord;
  WeatherRecordModel? get monthRainfallRecord => _weatherInfo?.monthRainfallRecord;

  String getSelectedDateAsString(BuildContext context) {
    final date = selectedDate;
    if (date != null) {
      final formatter = DateFormat('yMMMM', Localizations.localeOf(context).toString());
      return formatter.format(date).capitalize();
    }
    return '';
  }

  String getSelectedLocationAsString(BuildContext context) {
    if (!_locations.hasData) {
      return '';
    }

    String? result;
    if (_selectedCountryId != null && _selectedCityId != null) {
      result = _locations.findLocationNameBy(_selectedCountryId!, _selectedCityId!);
    }
    return result ?? AppLocalizations.of(context)!.selectYourLocation;
  }

  void _resetDate() {
    final now = DateTime.now();
    _selectedMonth = now.month;
    _selectedYear = now.year;
  }

  void _handleAppStart() async {
    _resetDate();
    await loadSettings();
    await fetchData();
  }

  Future<void> loadSettings() async {
    _selectedCountryId = await appSettings.getCountryId();
    _selectedCityId = await appSettings.getCityId();
    notifyListeners();
  }

  void changeDate(DateTime newDate) async {
    _selectedMonth = newDate.month;
    _selectedYear = newDate.year;
    await loadSettings();
    await fetchData();
  }

  void changeLocation({required int countryId, required int cityId}) async {
    _selectedCountryId = countryId;
    _selectedCityId = cityId;
    await appSettings.saveLocation(countryId, cityId);
    await fetchData();
  }

  void setTodayDate() {
    _resetDate();
    fetchData();
  }

  Future<void> fetchData() async {
    final cityId = _selectedCityId;
    if (cityId == null) {
      return;
    }

    _apiException = null;
    _apiStatus = WeatherApiStatus.loading;
    notifyListeners();
    try {
      _weatherInfo = await apiClient.fetchData(cityId: cityId, month: _selectedMonth, year: _selectedYear);
      _apiStatus = WeatherApiStatus.loaded;
      notifyListeners();
    } catch (e) {
      _apiException = e is ApiException ? e : null;
      _apiStatus = WeatherApiStatus.error;
      notifyListeners();
    }
  }
}