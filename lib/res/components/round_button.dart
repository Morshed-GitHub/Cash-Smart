// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onTap;
  final Color buttonColor;
  final Color textColor;

  const RoundButton({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onTap,
    this.buttonColor = Colors.blue,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator(
            color: Colors.blue,
          )
        : InkWell(
            onTap: onTap,
            child: Card(
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ),
              ),
            ),
          );
  }
}
