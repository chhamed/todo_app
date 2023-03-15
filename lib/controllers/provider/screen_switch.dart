import 'package:flutter/material.dart';

class ScreenSwitch extends ChangeNotifier {
  int currentIndex = 0;
  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
