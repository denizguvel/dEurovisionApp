import 'package:eurovision_app/app/features/data/datasources/remote/contestant_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/models/contestant_detail_model.dart';
import 'package:eurovision_app/core/result/result.dart';
import 'package:flutter/material.dart';

class ContestantDetailProvider extends ChangeNotifier {
  final ContestantDetailRemoteDatasource _datasource;

  ContestantDetailProvider(this._datasource);

  ContestantDetailModel? _detail;
  bool _loading = false;
  String? _error;

  ContestantDetailModel? get detail => _detail;
  bool get isLoading => _loading;
  String? get error => _error;

  Future<void> fetchDetail(int year, int id) async {
    _loading = true;
    _error = null;
    notifyListeners();

    final result = await _datasource.fetchContestantDetail(year: year, id: id);

    if (result is SuccessDataResult<ContestantDetailModel>) {
      _detail = result.data;
    } else if (result is ErrorDataResult<ContestantDetailModel>) {
      _error = result.message;
    }

    _loading = false;
    notifyListeners();
  }
}