import 'package:flutter/material.dart';

/// Base provider class for managing contestant data.
/// Handles state, error messages, and item list updates.
//For list classes
enum ContestantState { initial, loading, loaded, error }

abstract class BaseContestantProvider<T> extends ChangeNotifier {
  ContestantState _state = ContestantState.initial;
  String? _errorMessage;

  ContestantState get state => _state;
  String? get errorMessage => _errorMessage;

  List<T> _items = [];
  List<T> get items => _items;

  void setLoaded(List<T> newItems) {
    _items = newItems;
    _state = ContestantState.loaded;
    notifyListeners();
  }

  void setError(String? message) {
    _errorMessage = message;
    _state = ContestantState.error;
    notifyListeners();
  }
}