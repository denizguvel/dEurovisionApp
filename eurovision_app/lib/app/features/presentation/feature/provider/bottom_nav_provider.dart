import 'package:eurovision_app/core/constants/page_type_enum.dart';
import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int _currentIndex = 0;
  PageType _pageType = PageType.main;
  final Map<int, PageType> _lastViewedPages = {};
  int? selectedContestantId;
  int? selectedYear;

  int get currentIndex => _currentIndex;
  PageType get pageType => _pageType;

  void goToContestantDetail(PageType type, int id, int year) {
    selectedContestantId = id;
    selectedYear = year;
    _pageType = type;
    notifyListeners();
  }

  void changeIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      _pageType = _lastViewedPages[index] ?? PageType.main;
      notifyListeners();
    }
  }

  void changePageType(PageType type) {
    if (_pageType != type) {
      _pageType = type;
      _lastViewedPages[_currentIndex] = type;
      notifyListeners();
    }
  }

  void goToDetail(PageType type) {
    _pageType = type;
    _lastViewedPages[_currentIndex] = type;
    notifyListeners();
  }

  void goBackToMain() {
    _pageType = PageType.main;
    _lastViewedPages[_currentIndex] = PageType.main;
    notifyListeners();
  }
}