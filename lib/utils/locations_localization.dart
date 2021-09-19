import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationsLocalization {
  static String getCountryName(BuildContext context, String countryName) {
    switch (countryName) {
      case 'ukraine':
        return AppLocalizations.of(context)!.ukraine;
      case 'russia':
        return AppLocalizations.of(context)!.russia;
      default:
        return countryName;
    }
  }

  static String getCityName(BuildContext context, String cityName) {
    switch (cityName) {
      case 'kyiv':
        return AppLocalizations.of(context)!.kyiv;
      case 'kharkiv':
        return AppLocalizations.of(context)!.kharkiv;
      case 'vinnytsia':
        return AppLocalizations.of(context)!.vinnytsia;
      case 'heniches_k':
        return AppLocalizations.of(context)!.heniches_k;
      case 'dnipro':
        return AppLocalizations.of(context)!.dnipro;
      case 'zaporizhzhia':
        return AppLocalizations.of(context)!.zaporizhzhia;
      case 'ivanoFrankivsk':
        return AppLocalizations.of(context)!.ivanoFrankivsk;
      case 'izmail':
        return AppLocalizations.of(context)!.izmail;
      case 'konotop':
        return AppLocalizations.of(context)!.konotop;
      case 'kryvyi_Rih':
        return AppLocalizations.of(context)!.kryvyi_Rih;
      case 'kropyvnytskyi':
        return AppLocalizations.of(context)!.kropyvnytskyi;
      case 'lviv':
        return AppLocalizations.of(context)!.lviv;
      case 'mariupol':
        return AppLocalizations.of(context)!.mariupol;
      case 'odesa':
        return AppLocalizations.of(context)!.odesa;
      case 'poltava':
        return AppLocalizations.of(context)!.poltava;
      case 'rivne':
        return AppLocalizations.of(context)!.rivne;
      case 'uzhhorod':
        return AppLocalizations.of(context)!.uzhhorod;
      case 'kherson':
        return AppLocalizations.of(context)!.kherson;
      case 'chernihiv':
        return AppLocalizations.of(context)!.chernihiv;
      case 'chernivtsi':
        return AppLocalizations.of(context)!.chernivtsi;
      case 'moscow':
        return AppLocalizations.of(context)!.moscow;
      case 'saintPetersburg':
        return AppLocalizations.of(context)!.saintPetersburg;
      case 'novosibirsk':
        return AppLocalizations.of(context)!.novosibirsk;
      default:
        return cityName;
    }
  }
}