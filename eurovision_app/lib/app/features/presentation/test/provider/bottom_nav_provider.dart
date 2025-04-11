import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int _currentIndex = 0;
  bool _isDetailView = false;

  int get currentIndex => _currentIndex;
  bool get isDetailView => _isDetailView;

  void changeIndex(int index) {
    _currentIndex = index;
    _isDetailView = false;
    notifyListeners();
  }

  void showDetailView() {
    _isDetailView = true;
    notifyListeners();
  }

  void exitDetailView() {
    _isDetailView = false;
    notifyListeners();
  }
}
