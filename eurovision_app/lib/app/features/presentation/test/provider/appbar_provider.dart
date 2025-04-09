import 'package:flutter/material.dart';

class AppBarProvider extends ChangeNotifier {
  String _title = "Default Title";
  Widget _leadingIcon = const Icon(Icons.menu);
  List<Widget> _actions = [];

  String get title => _title;
  Widget get leadingIcon => _leadingIcon;
  List<Widget> get actions => _actions;

  // AppBar başlığını değiştiren metot
  void setTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  // Leading ikonunu değiştiren metot
  void setLeadingIcon(Widget newIcon) {
    _leadingIcon = newIcon;
    notifyListeners();
  }

  // AppBar'daki aksiyonları değiştiren metot
  void setActions(List<Widget> newActions) {
    _actions = newActions;
    notifyListeners();
  }
}
