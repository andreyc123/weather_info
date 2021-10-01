import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_info/models/home_model.dart';
import 'package:weather_info/models/weather_day_model.dart';
import 'package:weather_info/widgets/app_header_card.dart';
import 'package:weather_info/constants/constants.dart' as Constants;
import 'package:weather_info/widgets/weather_day.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TemperaturesPage extends StatelessWidget {
  final _scrollController = ScrollController();

  TemperaturesPage({Key? key}) : super(key: key);

  WeatherDay _buildDay(BuildContext context, WeatherDayModel dayModel, int number) {
    final loc = AppLocalizations.of(context)!;
    return WeatherDay(
        params: [
          WeatherParam(name: loc.minimum, value: dayModel.minAsString, color: Colors.blue),
          WeatherParam(name: loc.average, value: dayModel.averageAsString, color: Colors.green),
          WeatherParam(name: loc.maximum, value: dayModel.maxAsString, color: Colors.red),
          WeatherParam(name: loc.deviation, value: dayModel.deviationAsString, color: dayModel.deviationColor),
          WeatherParam(name: loc.rainfall, value: dayModel.rainfallAsString, color: Colors.blue)
        ],
        number: number,
        isRainfall: dayModel.isRainfall
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
        builder: (_, home, __) {
          final days = home.temperatureDays;
          return AppHeaderCard.arrowButtons(
              icon: Icons.thermostat_auto_outlined,
              title: AppLocalizations.of(context)!.temperature,
              child: days.isNotEmpty ? Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    return _buildDay(context, days[index], index + 1);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: Constants.appPadding,
                      endIndent: Constants.appPadding,
                    );
                  },
                  controller: _scrollController,
                ),
              ) : Center(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sentiment_dissatisfied_outlined,
                          color: Colors.red,
                          size: 40.0,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                            AppLocalizations.of(context)!.noData,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            )
                        )
                      ]
                  )
              ),
              onLeftButtonPressed: days.isNotEmpty ? () {
                _scrollController.jumpTo(_scrollController.position.minScrollExtent);
              } : null,
              onRightButtonPressed: days.isNotEmpty ? () {
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
              } : null
          );
        });
  }
}
