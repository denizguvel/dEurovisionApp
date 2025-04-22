import 'package:flutter/material.dart';

/// BaseListManager is an abstract class that extends ChangeNotifier
/// and provides a base implementation for list managers.
abstract class BaseListManager<T> extends ChangeNotifier {
  List<T> _items = [];
  List<T> get items => _items;

  void setItems(List<T> newItems) {
    _items = newItems;
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = _items.removeAt(oldIndex);
    _items.insert(newIndex, item);
    notifyListeners();
  }

  List<T> getTop(int count) {
    return _items.take(count).toList();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}