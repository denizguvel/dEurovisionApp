import 'package:eurovision_app/app/features/data/datasources/remote/cat_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/models/cat_model.dart';
import 'package:flutter/material.dart';

class CatProvider extends ChangeNotifier {
  final CatRemoteDatasource _catRemoteDatasource = CatRemoteDatasourceImpl();

  List<CatImageModel> _cats = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CatImageModel> get cats => _cats;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCats({int limit = 20}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _catRemoteDatasource.fetchCatImages(limit: limit);

    if (response.isSuccess) {
      _cats = response.data!;
    } else {
      _errorMessage = response.error?.message ?? "Bilinmeyen bir hata oluştu.";
    }

    _isLoading = false;
    notifyListeners();
  }
}
