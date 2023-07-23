import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormattedDate extends StatelessWidget {
  const FormattedDate({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String dayName = DateFormat('EEEE').format(now); // Monday, Tuesday, etc.
    String month = DateFormat('MMMM').format(now); // January, February, etc.
    String dayOfMonth = DateFormat('d').format(now); // 1, 2, 3, etc.
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        '$dayName, $dayOfMonth $month',
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
      ),
    );
  }
}
