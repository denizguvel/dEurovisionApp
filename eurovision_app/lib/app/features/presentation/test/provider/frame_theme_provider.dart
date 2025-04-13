import 'package:flutter/material.dart';

class FrameThemeProvider extends ChangeNotifier {
  Color _backgroundColor = Colors.white;
  TextStyle _fontStyle = const TextStyle(fontSize: 18, color: Colors.black);

  Color get backgroundColor => _backgroundColor;
  TextStyle get fontStyle => _fontStyle;

  void setTheme(Color color, TextStyle fontStyle) {
    _backgroundColor = color;
    _fontStyle = fontStyle;
    notifyListeners();
  }
}
