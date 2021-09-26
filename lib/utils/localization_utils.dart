String getLocalizedString(Map<String, dynamic> json, String locale) {
  if (locale == 'en') {
    return json[locale] as String;
  } else {
    final str = json[locale];
    return str != null ? str : json['en'] as String;
  }
}