import 'package:eurovision_app/app/features/data/datasources/remote/contestant_ten_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/eurovision_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/models/contest_model.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/contestant/constestant_provider.dart';
import 'package:eurovision_app/core/result/result.dart';
import 'package:flutter/material.dart';

class AllContestantsProvider extends ChangeNotifier {
  final ContestantTenRemoteDatasourceImpl _contestantDatasource;
  final EurovisionRemoteDatasourceImpl _eurovisionDatasource;

  AllContestantsProvider(this._contestantDatasource, this._eurovisionDatasource);

  List<ContestantModel> _allContestants = [];
  ContestantState _state = ContestantState.initial;
  String? _errorMessage;

  List<ContestantModel> get allContestants => _allContestants;
  ContestantState get state => _state;
  String? get errorMessage => _errorMessage;

  ContestModel? _contestDetails;
  ContestModel? get contestDetails => _contestDetails;

  Future<void> fetchAllContestants(int year) async {
  _state = ContestantState.loading;
  notifyListeners();

  final result = await _contestantDatasource.fetchTopContestants(year: year);

  if (result is SuccessDataResult<List<ContestantModel>>) {
    _allContestants = result.data ?? [];
    _state = ContestantState.loaded;

    final contestDetail = await _eurovisionDatasource.fetchContestDetail(year);
    if (contestDetail != null) {
      _contestDetails = contestDetail;
    }
  } else if (result is ErrorDataResult<List<ContestantModel>>) {
    _errorMessage = result.message;
    _state = ContestantState.error;
  }

  notifyListeners();
}


  Future<void> fetchContestDetail(int year) async {
    final response = await _eurovisionDatasource.fetchContestDetail(year);
    if (response != null) {
      _contestDetails = response;
      notifyListeners();
    }
  }
}