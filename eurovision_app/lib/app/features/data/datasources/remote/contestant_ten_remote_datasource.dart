import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/core/config/env_config.dart';
import 'package:eurovision_app/core/dio_manager/dio_manager.dart';
import 'package:eurovision_app/core/result/result.dart';

/// Remote data source for fetching top contestants of a given year.
/// Retrieves data from the API and converts it into a list of `ContestantModel`.
abstract class ContestantTenRemoteDatasource {
  Future<DataResult<List<ContestantModel>>> fetchTopContestants({required int year});
}

final class ContestantTenRemoteDatasourceImpl implements ContestantTenRemoteDatasource {
  final DioApiManager _dioApiManager =
      DioApiManager(baseUrl: EnvConfig.eurovisionBaseUrl);

  @override
  Future<DataResult<List<ContestantModel>>> fetchTopContestants({required int year}) async {
    try {
      final response = await _dioApiManager.get<List<ContestantModel>>(
        '/contests/$year',
        converter: (data) {
          if (data is Map<String, dynamic> && data.containsKey('contestants')) {
            final contestantsData = data['contestants'] as List;
            final contestants = contestantsData
                .map((e) => ContestantModel.fromJson(e as Map<String, dynamic>, year))
                .toList();
            return contestants;
          }
          return <ContestantModel>[]; 
        },
      );

      if (response.isSuccess && response.data != null) {
        return SuccessDataResult<List<ContestantModel>>(data: response.data!);
      } else {
        return ErrorDataResult<List<ContestantModel>>(message: response.error?.message ?? "Unknown Error");
      }
    } catch (e) {
      return ErrorDataResult<List<ContestantModel>>(message: "Server Error: ${e.toString()}");
    }
  }
}