import 'package:flutter/material.dart';

abstract class BaseSelectableListProvider<T> extends ChangeNotifier {
  final List<T> _selected = [];
  int maxItems;

  BaseSelectableListProvider({this.maxItems = 10});

  List<T> get selected => _selected;

  void toggle(T item) {
    if (_selected.contains(item)) {
      _selected.remove(item);
    } else if (_selected.length < maxItems) {
      _selected.add(item);
    }
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = _selected.removeAt(oldIndex);
    _selected.insert(newIndex, item);
    notifyListeners();
  }

  void clear() {
    _selected.clear();
    notifyListeners();
  }
}