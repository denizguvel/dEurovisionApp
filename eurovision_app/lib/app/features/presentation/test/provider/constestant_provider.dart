import 'package:eurovision_app/app/features/data/datasources/remote/contestant_ten_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:flutter/material.dart';
import 'package:eurovision_app/core/result/result.dart';

enum ContestantState { initial, loading, loaded, error }

class ContestantProvider extends ChangeNotifier {
  final ContestantTenRemoteDatasourceImpl _remoteDatasource;

  ContestantProvider(this._remoteDatasource);

  List<ContestantModel> _contestants = [];
  ContestantState _state = ContestantState.initial;
  String? _errorMessage;

  List<ContestantModel> get contestants => _contestants;
  ContestantState get state => _state;
  String? get errorMessage => _errorMessage;

   Future<void> fetchContestants(int year) async {
    _state = ContestantState.loading;
    notifyListeners();

    final result = await _remoteDatasource.fetchTopContestants(year: year);

    if (result is SuccessDataResult<List<ContestantModel>>) {
      //_contestants = result.data ?? [];
      _contestants = result.data?.take(10).toList() ?? [];
      _state = ContestantState.loaded;
    } else if (result is ErrorDataResult<List<ContestantModel>>) {
      _errorMessage = result.message;
      _state = ContestantState.error;
    }

    notifyListeners();
  }
}