import 'package:eurovision_app/app/features/data/models/contest_model.dart';
import 'package:eurovision_app/core/config/env_config.dart';
import 'package:eurovision_app/core/dio_manager/api_response_model.dart';
import 'package:eurovision_app/core/dio_manager/dio_manager.dart';

abstract class EurovisionRemoteDatasource {
  Future<ApiResponseModel<List<ContestModel>>> fetchContest({int year});
}

final class EurovisionRemoteDatasourceImpl implements EurovisionRemoteDatasource {
  final DioApiManager _dioApiManager =
      DioApiManager(baseUrl: EnvConfig.eurovisionBaseUrl);

  @override
  Future<ApiResponseModel<List<ContestModel>>> fetchContest({int year = 2024}) async {
      print("🚀 GET İsteği yapılıyor: /contest?year=$year");

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
}
