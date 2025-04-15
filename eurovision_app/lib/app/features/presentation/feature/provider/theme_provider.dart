import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  final String _boxName = "themeBox";

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveTheme(_themeMode);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    var box = await Hive.openBox(_boxName);
    bool isDark = box.get('isDarkMode', defaultValue: false);
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    var box = await Hive.openBox(_boxName);
    await box.put('isDarkMode', mode == ThemeMode.dark);
  }
}