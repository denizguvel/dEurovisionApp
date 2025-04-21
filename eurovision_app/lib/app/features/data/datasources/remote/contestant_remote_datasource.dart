import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/data/models/contestant_detail_model.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
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

  Future<DataResult<List<ContestantModel>>> fetchAllContestants({required int year}) async {
    try {
      final response = await _dioApiManager.get<List<dynamic>>(
        '/contests/$year',
        converter: (data) {
          if (data is Map<String, dynamic> && data.containsKey('contestants')) {
            final contestantsData = data['contestants'] as List;
            return contestantsData
                .map((e) => ContestantModel.fromJson(e as Map<String, dynamic>, year))
                .toList();
          }
          return <ContestantModel>[];
        },
      );

      if (response.isSuccess && response.data != null) {
        return SuccessDataResult<List<ContestantModel>>(data: response.data!.cast<ContestantModel>());
      } else {
        return ErrorDataResult<List<ContestantModel>>(message: response.error?.message ?? "Unknown error");
      }
    } catch (e) {
      return ErrorDataResult<List<ContestantModel>>(message: "Server Error: ${e.toString()}");
    }
  }

}