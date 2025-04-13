import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:flutter/material.dart';

class MyTop10Provider extends ChangeNotifier {
  List<ContestantModel> _contestants = [];

  List<ContestantModel> get contestants => _contestants;

  void setContestants(List<ContestantModel> list) {
    _contestants = list;
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = _contestants.removeAt(oldIndex);
    _contestants.insert(newIndex, item);
    notifyListeners();
  }

  List<ContestantModel> get top10 => _contestants.take(10).toList();
}