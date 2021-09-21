import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_info/models/home_model.dart';
import 'package:weather_info/models/weather_info_model.dart';
import 'package:weather_info/utils/string_utils.dart';
import 'package:weather_info/widgets/app_header_card.dart';
import 'package:provider/provider.dart';
import 'package:weather_info/constants/constants.dart' as Constants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({Key? key}) : super(key: key);

  List<Widget> _buildParamBlock({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required WeatherRecordModel recordModel,
    required bool isRainfall}) {

    String makeYear(int year) {
      return '$year ${AppLocalizations.of(context)!.year.toLowerCase()}';
    }

    final infoFontSize = 14.0;
    return [
      Row(children: [
        Icon(
            icon,
            color: iconColor
        ),
        SizedBox(width: 1.5 * Constants.appPadding),
        Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
            )
        )
      ]),
      ListTile(
          leading: Text(
              !isRainfall ? recordModel.max.temperatureAsString : recordModel.max.rainfallAsString,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: infoFontSize,
              )
          ),
          trailing: Text(
              makeYear(recordModel.max.year),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: infoFontSize,
              )
          )
      ),
      ListTile(
          leading: Text(
              !isRainfall ? recordModel.min.temperatureAsString : recordModel.min.rainfallAsString,
              style: TextStyle(
                color: Colors.blue,
                fontSize: infoFontSize,
              )
          ),
          trailing: Text(
              makeYear(recordModel.min.year),
              style: TextStyle(
                color: Colors.black,
                fontSize: infoFontSize,
              )
          )
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AppHeaderCard(
        icon: Icons.assessment_outlined,
        title: loc.records,
        child:  Consumer<HomeModel>(
            builder: (_, home, __) {
              final padding = 2 * Constants.appPadding;
              return ListView(
                padding: EdgeInsets.all(padding),
                children: [
                  if (home.monthTempRecord != null)
                    ..._buildParamBlock(
                        context: context,
                        icon: Icons.thermostat_auto_outlined,
                        iconColor: Colors.red,
                        title: loc.temperature,
                        recordModel: home.monthTempRecord!,
                        isRainfall: false
                    ),
                  Divider(
                    indent: padding,
                    endIndent: padding,
                  ),
                  if (home.monthRainfallRecord != null)
                    ..._buildParamBlock(
                        context: context,
                        icon: Icons.water,
                        iconColor: Colors.blue,
                        title: loc.rainfall.capitalize(),
                        recordModel: home.monthRainfallRecord!,
                        isRainfall: true
                    )
                ]);
            }
        )
    );
  }
}