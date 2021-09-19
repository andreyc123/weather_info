import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:weather_info/models/extreme_temp_model.dart';
import 'package:weather_info/models/home_model.dart';
import 'package:weather_info/models/weather_day_model.dart';
import 'package:weather_info/widgets/app_header_card.dart';
import 'package:weather_info/constants/constants.dart' as Constants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class _DayData {
  final int number;
  final double value;

  _DayData({required this.number, required this.value});
}

enum _TemperatureKind { minimum, maximum, average }

class ChartTemperaturePage extends StatelessWidget {
  const ChartTemperaturePage({Key? key}) : super(key: key);

  List<_DayData> _getTemperatureData({
    required List<WeatherDayModel> days,
    required _TemperatureKind kind}) {
    List<_DayData> data = [];
    for (int i = 0; i < days.length; i++) {
      final WeatherDayModel day = days[i];
      final double value;
      switch (kind) {
        case _TemperatureKind.minimum:
          value = day.min;
          break;
        case _TemperatureKind.maximum:
          value = day.max;
          break;
        case _TemperatureKind.average:
          value = day.average;
          break;
      }
      data.add(_DayData(number: i + 1, value: value));
    }
    return data;
  }

  List<_DayData> _getExtremeTemperatureData(List<ExtremeTemperatureModel> days) {
    List<_DayData> data = [];
    for (int i = 0; i < days.length; i++) {
      data.add(_DayData(number: i + 1, value: days[i].temperature));
    }
    return data;
  }

  charts.LineChart _buildChart({required HomeModel homeModel}) {
    final List<int> dashPattern = [4, 4];
    final days = homeModel.temperatureDays;
    final seriesList = [
      charts.Series<_DayData, int>(
        id: 'DayMaxTemp',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (_DayData dayData, _) => dayData.number,
        measureFn: (_DayData dayData, _) => dayData.value,
        data: _getTemperatureData(days: days, kind: _TemperatureKind.maximum),
      ),
      charts.Series<_DayData, int>(
        id: 'DayAverageTemp',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (_DayData dayData, _) => dayData.number,
        measureFn: (_DayData dayData, _) => dayData.value,
        data: _getTemperatureData(days: days, kind: _TemperatureKind.average),
      ),
      charts.Series<_DayData, int>(
        id: 'DayMinTemp',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (_DayData dayData, _) => dayData.number,
        measureFn: (_DayData dayData, _) => dayData.value,
        data: _getTemperatureData(days: days, kind: _TemperatureKind.minimum),
      ),
      charts.Series<_DayData, int>(
        id: 'MaxTemp',
        dashPatternFn: (_, __) => dashPattern,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (_DayData dayData, _) => dayData.number,
        measureFn: (_DayData dayData, _) => dayData.value,
        data: _getExtremeTemperatureData(homeModel.maxTemperatures),
      ),
      charts.Series<_DayData, int>(
        id: 'MinTemp',
        dashPatternFn: (_, __) => dashPattern,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (_DayData dayData, _) => dayData.number,
        measureFn: (_DayData dayData, _) => dayData.value,
        data: _getExtremeTemperatureData(homeModel.minTemperatures),
      ),
    ];
    return charts.LineChart(
      seriesList,
      animate: false,
      defaultRenderer: charts.LineRendererConfig(includePoints: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppHeaderCard(
        icon: Icons.bar_chart,
        title: AppLocalizations.of(context)!.chart,
        child: Consumer<HomeModel>(builder: (_, home, __) {
          return Padding(
            padding: const EdgeInsets.all(Constants.appPadding),
            child: _buildChart(homeModel: home),
          );
        })
    );
  }
}
