import 'dart:ui';
import 'package:flutter/material.dart';
import '../colors.dart';

class FrostedGlassBox extends StatefulWidget {
  const FrostedGlassBox(
      {super.key,
      required this.height,
      required this.width,
      required this.child});

  final double height;
  final double width;
  final Widget child;

  @override
  State<FrostedGlassBox> createState() => _FrostedGlassBoxState();
}

class _FrostedGlassBoxState extends State<FrostedGlassBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Scaffold Body
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        // Frosted Glass Container
        height: widget.height,
        width: widget.width,
        color: AppColors.transparentColor,

        /* 
        Glass Morphism contains three layers, such as 
            (i) Bottom Layer -> Blur Effect
            (ii) Middle Layer -> Gradient Effect
            (iii) Top Layer -> Child
        */
        child: Stack(
          children: [
            // Blur Effect
            blur(),

            //  Gradient Effect
            gradient(),

            // Child
            widget.child
          ],
        ),
      ),
    );
  }

  Container gradient() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.13)),
        gradient: LinearGradient(
          colors: [
            Colors.lightBlue.withOpacity(0.25),
            Colors.lightBlue.withOpacity(0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  BackdropFilter blur() {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4.0, // Horizontal Blur
        sigmaY: 4.0, // Vertical Blur
      ),
    );
  }
}
