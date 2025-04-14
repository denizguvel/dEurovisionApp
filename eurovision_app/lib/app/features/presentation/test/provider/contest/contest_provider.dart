import 'package:eurovision_app/core/providers/base_list_provider.dart';
import 'package:eurovision_app/app/features/data/models/contest_model.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/eurovision_remote_datasource.dart';

class ContestProvider extends BaseListProvider<ContestModel> {
  final EurovisionRemoteDatasource _eurovisionRemoteDatasource = EurovisionRemoteDatasourceImpl();

  List<int> _availableYears = [];
  List<int> get availableYears => _availableYears;

  Future<void> fetchAvailableYears() async {
    try {
      setLoading();
      final response = await _eurovisionRemoteDatasource.fetchAllContests();
      _availableYears = response.map((e) => e.year).toList()..sort((a, b) => b.compareTo(a));
      setLoaded(response);
    } catch (e) {
      setError("Failed to load years: $e");
    }
  }
}
