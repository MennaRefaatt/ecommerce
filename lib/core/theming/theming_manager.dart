import 'package:flutter/material.dart';
import '../helpers/shared_pref.dart';
import '../helpers/shared_pref_keys.dart';
import 'app_theme.dart';
//part 'theming_manager.g.dart';

abstract class ThemeManagerBase {
  bool isDarkMode = false;

  // bool get isDarkMode => isDarkMode;

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    print( " ====-=-=-=-=-=-=- ");
    SharedPref.putBoolean(key: MySharedKeys.isDarkMode, value: isDarkMode);
  }

  void init() {
    print(" ===== INIT =====");
    isDarkMode = SharedPref.getBoolean(
        key: MySharedKeys.isDarkMode, defaultValue: false);
  }


  //ThemeData get currentTheme => isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
}
