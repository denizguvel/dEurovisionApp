import 'package:eurovision_app/app/features/data/datasources/remote/contestant_ten_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/core/providers/base_provider.dart';
import 'package:eurovision_app/core/result/result.dart';

class ContestantProvider extends BaseContestantProvider<ContestantModel> {
  final ContestantTenRemoteDatasourceImpl _remoteDatasource;

  ContestantProvider(this._remoteDatasource);

  Future<void> fetchContestants(int year) async {
    setLoading();

    final result = await _remoteDatasource.fetchTopContestants(year: year);

    if (result is SuccessDataResult<List<ContestantModel>>) {
      setLoaded(result.data?.take(10).toList() ?? []);
    } else if (result is ErrorDataResult<List<ContestantModel>>) {
      setError(result.message);
    }
  }
}
