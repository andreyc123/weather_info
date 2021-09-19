import 'package:flutter/material.dart';
import 'package:weather_info/constants/constants.dart' as Constants;

class WeatherParam {
  final String name;
  final String value;
  final Color color;

  WeatherParam({required this.name, required this.value, required this.color});
}

class WeatherDay extends StatelessWidget {
  final List<WeatherParam> params;
  final int number;
  final bool isRainfall;

  const WeatherDay({
    Key? key,
    required this.params,
    required this.number,
    this.isRainfall = false}) : super(key: key);

  Text _buildParam({required String name, required Color color}) {
    return Text(
      name,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500
      ),
    );
  }

  Column _buildColumn({required List<String> titles, required List<Color> colors}) {
    List<Widget> widgets = [];
    for (int i = 0; i < titles.length; i++) {
      if (i > 0) {
        widgets.add(SizedBox(height: Constants.appTextSpacing));
      }
      widgets.add(_buildParam(name: titles[i], color: colors[i]));
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets
    );
  }

  @override
  Widget build(BuildContext context) {
    const double circleDiameter = 25.0;
    return Container(
        padding: EdgeInsets.fromLTRB(
            Constants.appPadding,
            (number == 1 ? 2 : 1) * Constants.appPadding,
            Constants.appPadding,
            Constants.appPadding
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: circleDiameter,
                  height: circleDiameter,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(0.5 * circleDiameter))
                  ),
                  child: Center(
                    child: Text(
                        number.toString(),
                        style: TextStyle(color: Colors.blue)
                    ),
                  )
              ),
              SizedBox(width: 1.5 * Constants.appPadding),
              _buildColumn(
                  titles: params.map((e) => e.name).toList(),
                  colors: List<Color>.filled(params.length, Colors.black)
              ),
              SizedBox(width: Constants.appPadding),
              _buildColumn(
                  titles: params.map((e) => e.value).toList(),
                  colors: params.map((e) => e.color).toList()
              ),
              if (isRainfall) Expanded(
                  child: Container(
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                              Icons.opacity_outlined,
                              size: 30.0,
                              color: Colors.blue
                          ),
                      )
                  )
              )
            ],
          ),
        )
    );
  }
}