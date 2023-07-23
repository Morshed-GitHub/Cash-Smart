import 'package:flutter/material.dart';

class BottomNavigatorViewModel with ChangeNotifier {
  // Provides screen refresh functionality
  int _currentIndex = 0;

  // Getter Method
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners(); // Notify if any update
  }
}
