import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:flutter/material.dart';

class AppBarProvider extends ChangeNotifier {
  String _title = AppStrings.appName;
  Widget _leadingIcon = const Icon(Icons.menu);
  List<Widget> _actions = [];

  String get title => _title;
  Widget get leadingIcon => _leadingIcon;
  List<Widget> get actions => _actions;

  void setTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  void setLeadingIcon(Widget newIcon) {
    _leadingIcon = newIcon;
    notifyListeners();
  }

  void setActions(List<Widget> newActions) {
    _actions = newActions;
    notifyListeners();
  }
}