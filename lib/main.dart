import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather_info/api_client/weather_web_api_client.dart';
import 'package:weather_info/common/shared_prefs_app_settings.dart';
import 'package:weather_info/models/home_model.dart';
import 'package:weather_info/models/locations_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_info/screens/home_page.dart';
import 'package:weather_info/screens/select_country_page.dart';
import 'common/app_storage_impl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiClient = WeatherWebApiClient();
    final appSettings = SharedPrefsAppSettings();
    final appStorage = AppStorageImpl();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationsModel>(create: (_) =>
            LocationsModel(appStorage: appStorage)),
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
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                  settings: RouteSettings(name: '/', arguments: Map()),
                  builder: (_) => HomePage()
              );
            case '/country':
              return MaterialPageRoute(builder: (_) => SelectCountryPage());
          }
          assert(false, 'Need to implement ${settings.name}');
          return null;
        },
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
      )
    );
  }
}