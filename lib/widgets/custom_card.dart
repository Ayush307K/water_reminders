import 'package:flutter/material.dart';

// Custom Card Widget
class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color color;

  CustomCard({
    required this.child,
    this.margin = const EdgeInsets.all(8.0),
    this.padding = const EdgeInsets.all(16.0),
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

