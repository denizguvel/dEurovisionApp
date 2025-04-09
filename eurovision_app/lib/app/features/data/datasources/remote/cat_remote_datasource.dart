import 'package:eurovision_app/app/features/data/models/cat_model.dart';
import 'package:eurovision_app/core/config/env_config.dart';
import 'package:eurovision_app/core/dio_manager/api_response_model.dart';
import 'package:eurovision_app/core/dio_manager/dio_manager.dart';

abstract class CatRemoteDatasource {
  Future<ApiResponseModel<List<CatImageModel>>> fetchCatImages({int limit});
}

final class CatRemoteDatasourceImpl implements CatRemoteDatasource {
  final DioApiManager _dioApiManager =
      DioApiManager(baseUrl: EnvConfig.apiBaseUrl);

  @override
  Future<ApiResponseModel<List<CatImageModel>>> fetchCatImages({int limit = 20}) async {
    // var apiResponseModel = await _dioApiManager.get(
    //   '/images/search',
    //   queryParams: {'limit': limit}, // API'nin desteklediği parametreler
    //   converter: (data) =>
    //       (data as List).map((e) => CatImageModel.fromMap(e)).toList(),
    // );
  print("🚀 GET İsteği yapılıyor: /images/search?limit=$limit");

    var apiResponseModel = await _dioApiManager.get(
      '/images/search',
      queryParams: {'limit': limit},
      headers: {'x-api-key': EnvConfig.apiKey},
      converter: (data) {
        print("🔥 API’den gelen data (converter içinde): $data");
        return (data as List).map((e) {
          print("📦 Tek item: $e");
          return CatImageModel.fromMap(e);
        }).toList();
      },
    );
    

  print("👉 Gelen veri: ${apiResponseModel.data}");
  print("❌ Hata varsa: ${apiResponseModel.error?.message}");
  print("Cat API Full Response: $apiResponseModel");
  print("Cat API Response Error: ${apiResponseModel.error}");

    return apiResponseModel;
  }
}
