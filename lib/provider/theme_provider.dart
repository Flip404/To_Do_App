import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  bool get isDarkMode => mode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    mode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
