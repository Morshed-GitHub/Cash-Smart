import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void changeFocusNode(BuildContext context,
      {required FocusNode current, required FocusNode next}) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        textColor: Colors.white,
        fontSize: 18,
        backgroundColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT);
  }

  static snackBar(BuildContext context,
      {required String message, String desc = "", bool isErrorMsg = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: SingleChildScrollView(
          // In order to ignore overflow issue, when message is too large
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon(isErrorMsg),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  msg(message),
                  SizedBox(height: 6),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: isErrorMsg ? Colors.red : Colors.green,
        elevation: 2,
      ),
    );
  }

  static Text msg(String message) {
    return Text(
      message,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }

  static Icon icon(bool isErrorMsg) {
    return Icon(
      isErrorMsg ? Icons.error_outline_sharp : Icons.thumb_up,
      color: Colors.white.withOpacity(.8),
    );
  }
}
