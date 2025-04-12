import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/data/models/contestant_detail_model.dart';
import 'package:eurovision_app/core/config/env_config.dart';
import 'package:eurovision_app/core/dio_manager/dio_manager.dart';
import 'package:eurovision_app/core/result/result.dart';

abstract class ContestantDetailRemoteDatasource {
  Future<DataResult<ContestantDetailModel>> fetchContestantDetail({
    required int year,
    required int id,
  });
}

final class ContestantDetailRemoteDatasourceImpl implements ContestantDetailRemoteDatasource {
  final DioApiManager _dioApiManager = DioApiManager(
    baseUrl: EnvConfig.eurovisionBaseUrl,
  );

  @override
  Future<DataResult<ContestantDetailModel>> fetchContestantDetail({
    required int year,
    required int id,
  }) async {
    try {
      final response = await _dioApiManager.get<ContestantDetailModel>(
        '/contests/$year/contestants/$id',
        converter: (data) {
          if (data is Map<String, dynamic>) {
            return ContestantDetailModel.fromJson(data, year);
          }
          throw Exception(AppStrings.invalidData);
        },
      );

      if (response.isSuccess && response.data != null) {
        return SuccessDataResult<ContestantDetailModel>(data: response.data!);
      } else {
        return ErrorDataResult<ContestantDetailModel>(
          message: response.error?.message ?? AppStrings.unknownError,
        );
      }
    } catch (e) {
      return ErrorDataResult<ContestantDetailModel>(
        message: "${AppStrings.serverError} ${e.toString()}",
      );
    }
  }
}