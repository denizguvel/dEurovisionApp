import 'package:eurovision_app/app/features/data/models/contest_model.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/core/config/env_config.dart';
import 'package:eurovision_app/core/dio_manager/dio_manager.dart';

/// Remote data source for Eurovision contests.
/// Handles API calls for all contests, yearly winners, and contest details.
abstract class EurovisionRemoteDatasource {
  Future<List<ContestModel>> fetchAllContests();
  Future<ContestantModel?> fetchWinnerByYear(int year);
  Future<ContestModel?> fetchContestDetail(int year);
}

final class EurovisionRemoteDatasourceImpl implements EurovisionRemoteDatasource {
  final DioApiManager _dioApiManager =
      DioApiManager(baseUrl: EnvConfig.eurovisionBaseUrl);

  @override
  Future<List<ContestModel>> fetchAllContests() async {
    final response = await _dioApiManager.get<List<ContestModel>>(
      '/contests',
      converter: (data) {
        if (data is List) {
          return data.map((e) => ContestModel.fromJson(e)).toList();
        } else {
          return <ContestModel>[];
        }
      },
    );
    return response.data ?? [];
  }

  @override
  Future<ContestantModel?> fetchWinnerByYear(int year) async {
    final response = await _dioApiManager.get<Map<String, dynamic>>(
      '/contests/$year',
      converter: (data) => data,
    );

    final contestants = response.data?['contestants'] as List?;
    if (contestants != null && contestants.isNotEmpty) {
      return ContestantModel.fromJson(contestants[0], year);
    }

    return null;
  }

  @override
  Future<ContestModel?> fetchContestDetail(int year) async {
    try {
      final response = await _dioApiManager.get<Map<String, dynamic>>(
        '/contests/$year',
        converter: (data) => data,
      );

      if (response.isSuccess && response.data != null) {
        return ContestModel.fromJson(response.data!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}