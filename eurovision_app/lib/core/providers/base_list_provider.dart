import 'package:flutter/material.dart';

/// Base provider class for managing list data.
/// Handles loading state, error messages, and data updates.
abstract class BaseListProvider<T> extends ChangeNotifier {
  List<T> _items = [];
  bool _isLoading = false;
  String? _error;

  List<T> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void setLoaded(List<T> data) {
    _items = data;
    _isLoading = false;
    notifyListeners();
  }

  void setError(String message) {
    _error = message;
    _isLoading = false;
    notifyListeners();
  }
}
