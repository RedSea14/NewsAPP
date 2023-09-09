import 'package:flutter/material.dart';

enum ThemeModeEnum { Light, Dark }

class ThemeProvider extends ChangeNotifier {
  GlobalKey<ScaffoldState> keyDrawer = GlobalKey<ScaffoldState>();
  ThemeModeEnum _themeMode = ThemeModeEnum.Light;

  ThemeModeEnum get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeModeEnum.Light
        ? ThemeModeEnum.Dark
        : ThemeModeEnum.Light;
    notifyListeners();
  }

  void close() {
    keyDrawer.currentState!.openEndDrawer();
  }
}
