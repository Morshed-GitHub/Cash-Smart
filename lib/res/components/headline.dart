import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  final String title;
  final Color color;
  const Headline({
    super.key,
    required this.title,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
