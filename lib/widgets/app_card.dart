import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const AppCard({
    Key? key,
    required this.child,
    this.margin,
    this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: Colors.white,
        elevation: 10.0,
        shadowColor: Colors.black.withOpacity(0.75),
        margin: margin,
        child: padding != null ? Padding(child: child, padding: padding!) : child
    );
  }
}
