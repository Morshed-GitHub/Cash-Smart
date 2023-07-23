import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  final String TOKEN = "token";

  Future setUser(String? token) async {
    final SharedPreferences SP = await SharedPreferences.getInstance();
    SP.setString(TOKEN, token.toString());
    notifyListeners();
  }

  Future getUser() async {
    final SharedPreferences SP = await SharedPreferences.getInstance();
    final String? token = SP.getString(TOKEN) ?? "";
    debugPrint("Token User View Model: " + token.toString());
    return token.toString();
  }

  Future removeUser() async {
    final SharedPreferences SP = await SharedPreferences.getInstance();
    SP.remove(TOKEN);
  }
}
