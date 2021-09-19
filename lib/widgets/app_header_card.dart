import 'package:flutter/material.dart';
import 'package:weather_info/widgets/app_card.dart';
import 'package:weather_info/constants/constants.dart' as Constants;

class AppHeaderCard extends StatelessWidget {
  final Widget child;
  final IconData? icon;
  final String title;

  const AppHeaderCard({
    Key? key,
    required this.child,
    required this.icon,
    required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Colors.black87;
    return AppCard(
      margin: EdgeInsets.fromLTRB(Constants.appMargin, 0, Constants.appMargin, Constants.appMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.blue[200],
            padding: EdgeInsets.all(Constants.appPadding),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                      icon,
                      size: 18.0,
                      color: color
                  ),
                  SizedBox(width: 4.0),
                  Text(
                      title,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold
                      )
                  )
                ],
              ),
            )
          ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
