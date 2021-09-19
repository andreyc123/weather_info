abstract class AppSettings {
  Future<int?> getCountryId();
  Future<int?> getCityId();
  Future saveLocation(int countryId, int cityId);
}