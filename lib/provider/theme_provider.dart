import 'package:flutter/material.dart';
import 'package:music_player_app/themes/dark_theme.dart';
import 'package:music_player_app/themes/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  static ThemeProvider instance = ThemeProvider();

  ThemeData themeData = lightMode;

  bool get isDarkMode => themeData == darkMode;

  ThemeData get getCurrentTheme => themeData;

  set newTheme(ThemeData themeData) {
    this.themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    notifyListeners();
  }
}
