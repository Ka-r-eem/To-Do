import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLocale = 'en';

  void changeTheme(ThemeMode newTheme) {
    if (newTheme == currentTheme) {
      return;
    }
    currentTheme = newTheme;
    notifyListeners();
  }

  // String getBackgroundImage(){
  //   return currentTheme == ThemeMode.dark ?"assets/images/darkBackground.png":
  //   "assets/images/main_background.png";
  // }


  bool isDarkEnabled(){
    return currentTheme == ThemeMode.dark;
  }

  void changeLanguage(String local){

if (local == currentLocale) return;
currentLocale = local;
notifyListeners();

  }

}
