// import 'package:flutter/material.dart';

// class BottomNavProvider extends ChangeNotifier {
//   int _currentIndex = 0;
//   bool _isDetailView = false;

//   int get currentIndex => _currentIndex;
//   bool get isDetailView => _isDetailView;

//   void changeIndex(int index) {
//     _currentIndex = index;
//     _isDetailView = false;
//     notifyListeners();
//   }

//   void showDetailView() {
//     _isDetailView = true;
//     notifyListeners();
//   }

//   void exitDetailView() {
//     _isDetailView = false;
//     notifyListeners();
//   }
// }

import 'package:eurovision_app/core/constants/page_type_enum.dart';
import 'package:flutter/material.dart';

class BottomNavProvider with ChangeNotifier {
  int _currentIndex = 0;
  PageType _pageType = PageType.main;

  int get currentIndex => _currentIndex;
  PageType get pageType => _pageType;

  void changeIndex(int index) {
    _currentIndex = index;
    if (_pageType != PageType.main) {
    _pageType = PageType.main;
  }
    //_pageType = PageType.main;
    notifyListeners();
  }

  void goToDetail(PageType type) {
    _pageType = type;
    notifyListeners();
  }

  void goBackToMain() {
    _pageType = PageType.main;
    notifyListeners();
  }
}