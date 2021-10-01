import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_info/models/extreme_temp_model.dart';
import 'package:weather_info/models/home_model.dart';
import 'package:weather_info/widgets/app_header_card.dart';
import 'package:weather_info/widgets/weather_day.dart';
import 'package:weather_info/constants/constants.dart' as Constants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ExtremeTemperatureKind { minimum, maximum }

class ExtremeTemperaturesPage extends StatelessWidget {
  final ExtremeTemperatureKind kind;
  final Color _color;
  final _scrollController = ScrollController();

  ExtremeTemperaturesPage({
    required this.kind
  }) : _color = kind == ExtremeTemperatureKind.minimum ? Colors.blue : Colors.red;

  WeatherDay _buildDay(BuildContext context, ExtremeValueModel dayModel, int number) {
    final loc = AppLocalizations.of(context)!;
    return WeatherDay(
        params: [
          WeatherParam(name: loc.year, value: dayModel.yearAsString, color: Colors.blueGrey),
          WeatherParam(name: loc.temp, value: dayModel.temperatureAsString, color: _color)
        ],
        number: number
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    IconData icon;
    String prefix;
    switch (kind) {
      case ExtremeTemperatureKind.minimum:
        icon = Icons.trending_down_outlined;
        prefix = loc.min;
        break;
      case ExtremeTemperatureKind.maximum:
        icon = Icons.trending_up_outlined;
        prefix = loc.max;
        break;
    }

    final localizedTemp = loc.temperature.toLowerCase();
    return AppHeaderCard.arrowButtons(
        icon: icon,
        title: prefix + ' ' + localizedTemp,
        child: Consumer<HomeModel>(
            builder: (_, home, __) {
              final List<ExtremeValueModel> days;
              switch (kind) {
                case ExtremeTemperatureKind.minimum:
                  days = home.minTemperatures;
                  break;
                case ExtremeTemperatureKind.maximum:
                  days = home.maxTemperatures;
                  break;
              }
              return Scrollbar(
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
              );
            }),
        onLeftButtonPressed: () {
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
        },
        onRightButtonPressed: () {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
    );
  }
}