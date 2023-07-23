import 'package:flutter/material.dart';
import '../user_view_model.dart';

class Services {
  // Concise way to define a getter method named "getUserData()" by calling the
  // "getUser()" method from an instance of the "UserViewModel" class
  Future<String> getUserData() async => await UserViewModel().getUser();

  Future<bool> checkUserSession() async {
    try {
      final value = await getUserData();
      debugPrint(value);

      // In getUser, we return the result in toString format, so if it is null, then we get the string "null"
      if (value == "null" || value == "") {
        return false;
      } else {
        return true;
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
