import 'package:eurovision_app/core/providers/base_provider.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/contestant_ten_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/eurovision_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/models/contest_model.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/core/result/result.dart';


class AllContestantsProvider extends BaseContestantProvider<ContestantModel> {
  final ContestantTenRemoteDatasourceImpl _contestantDatasource;
  final EurovisionRemoteDatasourceImpl _eurovisionDatasource;

  AllContestantsProvider(this._contestantDatasource, this._eurovisionDatasource);

  ContestModel? _contestDetails;
  ContestModel? get contestDetails => _contestDetails;

  Future<void> fetchAllContestants(int year) async {
    setLoading();

    final result = await _contestantDatasource.fetchTopContestants(year: year);

    if (result is SuccessDataResult<List<ContestantModel>>) {
      setLoaded(result.data ?? []);

      final contestDetail = await _eurovisionDatasource.fetchContestDetail(year);
      if (contestDetail != null) {
        _contestDetails = contestDetail;
      }
    } else if (result is ErrorDataResult<List<ContestantModel>>) {
      setError(result.message);
    }
  }

  Future<void> fetchContestDetail(int year) async {
    final response = await _eurovisionDatasource.fetchContestDetail(year);
    if (response != null) {
      _contestDetails = response;
      notifyListeners();
    }
  }
}
