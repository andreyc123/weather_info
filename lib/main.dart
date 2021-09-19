import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather_info/api_client/weather_web_api_client.dart';
import 'package:weather_info/common/shared_prefs_app_settings.dart';
import 'package:weather_info/models/home_model.dart';
import 'package:weather_info/models/locations_model.dart';
import 'package:weather_info/screens/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiClient = WeatherWebApiClient();
    final appSettings = SharedPrefsAppSettings();
    return MultiProvider(
      providers: [
        Provider(create: (_) => LocationsModel()),
        ChangeNotifierProxyProvider<LocationsModel, HomeModel>(
          create: (_) => HomeModel(apiClient: apiClient, appSettings: appSettings),
          update: (_, locations, home) {
            if (home == null) throw ArgumentError.notNull('home');
            home.locations = locations;
            return home;
          }
        )
      ],
      child: MaterialApp(
        title: 'Weather Monitor',
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
          Locale('ru', ''),
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      )
    );
  }
}