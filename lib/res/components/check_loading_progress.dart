import 'package:flutter/material.dart';

class CheckLoadingProgress extends StatelessWidget {
  final ImageChunkEvent? loadingProgress;
  final Widget child;
  const CheckLoadingProgress(
      {super.key, required this.loadingProgress, required this.child});

  @override
  Widget build(BuildContext context) {
    return (loadingProgress == null)
        ? child
        : SizedBox(
            height: 70,
            width: 50,
            child: Align(
              alignment: Alignment.center, // In order not to take whole space
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
              ),
            ),
          );
  }
}
