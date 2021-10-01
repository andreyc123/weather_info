import 'package:flutter/material.dart';
import 'package:weather_info/widgets/app_card.dart';
import 'package:weather_info/constants/constants.dart' as Constants;

class AppHeaderCard extends StatelessWidget {
  final Widget child;
  final IconData? icon;
  final String title;
  final Widget? leftHeaderWidget;
  final Widget? rightHeaderWidget;

  static final Color _mainColor = Colors.black87;

  const AppHeaderCard({
    Key? key,
    required this.child,
    required this.icon,
    required this.title,
    this.leftHeaderWidget,
    this.rightHeaderWidget
  }) : super(key: key);

  factory AppHeaderCard.arrowButtons({
    required Widget child,
    required IconData? icon,
    required String title,
    required VoidCallback onLeftButtonPressed,
    required VoidCallback onRightButtonPressed}) {
    return AppHeaderCard(
        child: child,
        icon: icon,
        title: title,
        leftHeaderWidget: IconButton(
            icon: Icon(Icons.arrow_circle_up, color: _mainColor),
            onPressed: onLeftButtonPressed
        ),
        rightHeaderWidget: IconButton(
            icon: Icon(Icons.arrow_circle_down, color: _mainColor),
            onPressed: onRightButtonPressed
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.fromLTRB(Constants.appMargin, 0, Constants.appMargin, Constants.appMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
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
                            color: _mainColor
                        ),
                        SizedBox(width: 4.0),
                        Text(
                            title,
                            style: TextStyle(
                                color: _mainColor,
                                fontWeight: FontWeight.bold
                            )
                        )
                      ],
                    ),
                  )
              ),
              if (leftHeaderWidget != null)
                Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: leftHeaderWidget!
                ),
              if (rightHeaderWidget != null)
                Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: rightHeaderWidget!
                )
            ],
          ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
