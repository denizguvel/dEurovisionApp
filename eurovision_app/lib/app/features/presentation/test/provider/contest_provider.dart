import 'package:eurovision_app/app/features/data/datasources/remote/eurovision_remote_datasource.dart';
import 'package:flutter/material.dart';
import 'package:eurovision_app/app/features/data/models/contest_model.dart';

class ContestProvider extends ChangeNotifier {
  final EurovisionRemoteDatasource _eurovisionRemoteDatasource = EurovisionRemoteDatasourceImpl();

  List<ContestModel> _contests = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ContestModel> get contests => _contests;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchContests({int year = 2024}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _eurovisionRemoteDatasource.fetchContestYear(year: year);

    if (response.isSuccess) {
      _contests = response.data ?? [];
    } else {
      _errorMessage = response.error?.message ?? "Bilinmeyen bir hata oluştu.";
    }

    _isLoading = false;
    notifyListeners();
  }
}
