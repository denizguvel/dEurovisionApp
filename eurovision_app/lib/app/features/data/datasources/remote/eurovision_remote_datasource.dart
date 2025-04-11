// import 'package:eurovision_app/app/features/data/models/contest_model.dart';
// import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
// import 'package:eurovision_app/core/config/env_config.dart';
// import 'package:eurovision_app/core/dio_manager/api_response_model.dart';
// import 'package:eurovision_app/core/dio_manager/dio_manager.dart';

// abstract class EurovisionRemoteDatasource {
//   Future<ApiResponseModel<List<ContestModel>>> fetchContestYear({int year});
//    Future<List<ContestModel>> fetchAllContests();
// }

// final class EurovisionRemoteDatasourceImpl implements EurovisionRemoteDatasource {
//   final DioApiManager _dioApiManager =
//       DioApiManager(baseUrl: EnvConfig.eurovisionBaseUrl);

//   @override
//   Future<ApiResponseModel<List<ContestModel>>> fetchContestYear({int year = 2024}) async {
//     var apiResponseModel = await _dioApiManager.get<List<ContestModel>>(
//       '/contests',
//       queryParams: {'year': year},
//       converter: (data) {
//         if (data is List) {
//           return data.map((e) => ContestModel.fromJson(e)).toList();
//         } else {
//           return <ContestModel>[];
//         }
//       },
//     );

//     return apiResponseModel;
//   }

//   Future<List<ContestModel>> fetchAllContests() async {
//     final response = await _dioApiManager.get<List<ContestModel>>(
//       '/contests',
//       converter: (data) {
//         if (data is List) {
//           return data.map((e) => ContestModel.fromJson(e)).toList();
//         } else {
//           return <ContestModel>[];
//         }
//       },
//     );
//     return response.data ?? [];
//   }


//   Future<ContestantModel?> fetchWinnerByYear(int year) async {
//     final response = await _dioApiManager.get<Map<String, dynamic>>(
//       '/contests/$year',
//       converter: (data) => data,
//     );

//     final contestants = response.data?['contestants'] as List?;
//     if (contestants != null && contestants.isNotEmpty) {
//       return ContestantModel.fromJson(contestants[0]);
//     }

//     return null;
//   }

// }

import 'package:eurovision_app/app/features/data/models/contest_model.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/core/config/env_config.dart';
import 'package:eurovision_app/core/dio_manager/api_response_model.dart';
import 'package:eurovision_app/core/dio_manager/dio_manager.dart';

abstract class EurovisionRemoteDatasource {
  Future<ApiResponseModel<List<ContestModel>>> fetchContestYear({int year});
  Future<List<ContestModel>> fetchAllContests();
  Future<ContestantModel?> fetchWinnerByYear(int year);
}

final class EurovisionRemoteDatasourceImpl implements EurovisionRemoteDatasource {
  final DioApiManager _dioApiManager =
      DioApiManager(baseUrl: EnvConfig.eurovisionBaseUrl);

  @override
  Future<ApiResponseModel<List<ContestModel>>> fetchContestYear({int year = 2024}) async {
    var apiResponseModel = await _dioApiManager.get<List<ContestModel>>(
      '/contests',
      queryParams: {'year': year},
      converter: (data) {
        if (data is List) {
          return data.map((e) => ContestModel.fromJson(e)).toList();
        } else {
          return <ContestModel>[];
        }
      },
    );

    return apiResponseModel;
  }

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

  Future<ContestantModel?> fetchWinnerByYear(int year) async {
    final response = await _dioApiManager.get<Map<String, dynamic>>(
      '/contests/$year',
      converter: (data) => data,
    );

    final contestants = response.data?['contestants'] as List?;
    if (contestants != null && contestants.isNotEmpty) {
      return ContestantModel.fromJson(contestants[0]);
    }

    return null;
  }
}

