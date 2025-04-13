import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:flutter/material.dart';

class SelectedTop10Provider extends ChangeNotifier {
  final List<ContestantModel> _selected = [];

  List<ContestantModel> get selected => _selected;

  void toggleSelection(ContestantModel contestant) {
    if (_selected.contains(contestant)) {
      _selected.remove(contestant);
    } else {
      if (_selected.length < 10) {
        _selected.add(contestant);
      }
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