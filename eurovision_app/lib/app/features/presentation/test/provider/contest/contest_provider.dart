import 'package:eurovision_app/app/common/constants/app_strings.dart';
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

  List<int> _availableYears = [];
  List<int> get availableYears => _availableYears;

  // Future<void> fetchContests({int year = 2024}) async {
  //   _isLoading = true;
  //   _errorMessage = null;
  //   notifyListeners();

  //   final response = await _eurovisionRemoteDatasource.fetchContestYear(year: year);

  //   if (response.isSuccess) {
  //     _contests = response.data ?? [];
  //   } else {
  //     _errorMessage = response.error?.message ?? AppStrings.unknownError;
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  // }

  

Future<void> fetchAvailableYears() async {
  final response = await _eurovisionRemoteDatasource.fetchAllContests();
  _availableYears = response.map((e) => e.year).toList()..sort((a, b) => b.compareTo(a));
  notifyListeners();
}

}
