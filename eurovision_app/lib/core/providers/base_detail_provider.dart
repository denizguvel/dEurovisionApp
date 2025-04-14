import 'package:flutter/material.dart';
//For detail(object) classes
abstract class BaseDetailProvider<T> extends ChangeNotifier {
  T? _item;
  bool _loading = false;
  String? _error;

  T? get item => _item;
  bool get isLoading => _loading;
  String? get error => _error;

  void setLoading() {
    _loading = true;
    _error = null;
    notifyListeners();
  }

  void setLoaded(T newItem) {
    _item = newItem;
    _loading = false;
    notifyListeners();
  }

  void setError(String message) {
    _error = message;
    _loading = false;
    notifyListeners();
  }
}