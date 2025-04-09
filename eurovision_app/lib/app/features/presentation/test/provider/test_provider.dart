import 'package:eurovision_app/app/features/data/models/test_model.dart';
import 'package:eurovision_app/app/features/data/repositories/test_repository.dart';
import 'package:eurovision_app/core/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';

class TestProvider with ChangeNotifier {
  final TestRepository _testRepository;

  bool _isLoading = false;
  List<TestModel> _testList = [];

  TestProvider({required TestRepository testRepository})
      : _testRepository = testRepository;

  bool get isLoading => _isLoading;
  List<TestModel> get testList => _testList;

  Future<void> getAllTests() async {
    _isLoading = true;
    _testList = [];
    notifyListeners();

    await Future.delayed(const Duration(seconds: 4)); // Durations.extralong4 * 4

    var dataResult = await _testRepository.getAll();
    if (!dataResult.success) {
      AppSnackBar.show(dataResult.message ?? "Unknown error");
      _isLoading = false;
      notifyListeners();
      return;
    }

    _testList = dataResult.data!;
    _isLoading = false;
    notifyListeners();
  }
}