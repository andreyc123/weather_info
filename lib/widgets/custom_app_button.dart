import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final double elevation;
  final VoidCallback? onPressed;

  const CustomAppButton({
    Key? key,
    required this.iconData,
    required this.title,
    this.elevation = 2.0,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Colors.black54;
    return ElevatedButton.icon(
      icon: Icon(
          iconData,
          color: color
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.blue[200],
          onPrimary: Colors.white,
          shadowColor: Colors.grey,
          elevation: elevation
      ),
      label: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black54
          )
      ),
      onPressed: onPressed,
    );
  }
}