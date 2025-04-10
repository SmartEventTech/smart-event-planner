import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/theme/theme_manager.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode;

  ThemeProvider(this._themeMode);

  ThemeMode get themeMode => _themeMode;

  Future<void> setTheme(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    await ThemeManager.setThemeMode(mode);
    notifyListeners();
  }
}
