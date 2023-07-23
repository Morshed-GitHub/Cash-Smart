import 'package:flutter/material.dart';

class infoText extends StatelessWidget {
  final String title;
  final Color color;
  final double? fontSize;
  const infoText(
      {super.key,
      required this.title,
      required this.color,
      this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
