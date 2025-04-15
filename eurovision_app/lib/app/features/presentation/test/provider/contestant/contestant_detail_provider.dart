import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/core/providers/base_detail_provider.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/contestant_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/models/contestant_detail_model.dart';
import 'package:eurovision_app/core/result/result.dart';


class ContestantDetailProvider extends BaseDetailProvider<ContestantDetailModel> {
  final ContestantDetailRemoteDatasource _datasource;

  ContestantDetailProvider(this._datasource);

  Future<void> fetchDetail(int year, int id) async {
    setLoading();

    final result = await _datasource.fetchContestantDetail(year: year, id: id);

    if (result is SuccessDataResult<ContestantDetailModel>) {
      setLoaded(result.data!);
    } else if (result is ErrorDataResult<ContestantDetailModel>) {
      setError(result.message ?? AppStrings.unknownError);
    }
  }
}