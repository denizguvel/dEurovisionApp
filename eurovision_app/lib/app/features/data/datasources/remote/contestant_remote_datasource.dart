import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/data/models/contestant_detail_model.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/core/config/env_config.dart';
import 'package:eurovision_app/core/dio_manager/dio_manager.dart';
import 'package:eurovision_app/core/result/result.dart';


/// Remote data source for fetching contestant details and yearly contestant list.
/// Handles API requests and data conversion using Dio.
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

  Future<DataResult<List<int>>> fetchAvailableYears() async {
    try {
      final response = await _dioApiManager.get<List<dynamic>>(
        '/contests',
        converter: (data) {
          if (data is List) {
            return data
                .map((e) => (e as Map<String, dynamic>)['year'] as int)
                .toList();
          }
          return <int>[];
        },
      );

      if (response.isSuccess && response.data != null) {
        return SuccessDataResult<List<int>>(data: response.data!.cast<int>());
      } else {
        return ErrorDataResult<List<int>>(
            message: response.error?.message ?? "Unknown error");
      }
    } catch (e) {
      return ErrorDataResult<List<int>>(
          message: "Server Error: ${e.toString()}");
    }
  }

  Future<DataResult<List<ContestantModel>>> fetchAllContestants() async {
    try {
      final response = await _dioApiManager.get<List<dynamic>>(
        '/contestants',
        converter: (data) {
          if (data is List) {
            return data
                .map((e) => ContestantModel.fromJson(e, e['year'] as int))
                .toList();
          }
          return <ContestantModel>[];
        },
      );

      if (response.isSuccess && response.data != null) {
        return SuccessDataResult<List<ContestantModel>>(data: response.data!.cast<ContestantModel>());
      } else {
        return ErrorDataResult<List<ContestantModel>>(
            message: response.error?.message ?? "Unknown error");
      }
    } catch (e) {
      return ErrorDataResult<List<ContestantModel>>(
          message: "Server Error: ${e.toString()}");
    }
  }
}