import 'package:flutter/material.dart';

class FrameThemeProvider extends ChangeNotifier {
  Color _backgroundColor = Colors.white;
  TextStyle _titleFontStyle = const TextStyle(fontSize: 18, color: Colors.black);
  TextStyle _subTitleFontStyle = const TextStyle(fontSize: 18, color: Colors.black);
  TextStyle _trailingFontStyle = const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w100 );

  Color get backgroundColor => _backgroundColor;
  TextStyle get titleFontStyle => _titleFontStyle;
  TextStyle get subTitleFontStyle => _subTitleFontStyle;
  TextStyle get trailingFontStyle => _trailingFontStyle;

  void setTheme(Color color, TextStyle titleFontStyle, subTitleFontStyle, trailingFontStyle) {
    _backgroundColor = color;
    _titleFontStyle = titleFontStyle;
    _subTitleFontStyle = subTitleFontStyle;
    _trailingFontStyle = trailingFontStyle;
    notifyListeners();
  }
}
