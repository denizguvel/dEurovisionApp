import 'package:eurovision_app/core/dio_manager/api_error_model.dart';

class ApiResponseModel<T> {
  final T? data;
  final ApiErrorModel? error;
  final bool isSuccess;

  ApiResponseModel.success(
    T this.data,
  )   : error = null,
        isSuccess = true;

  ApiResponseModel.error(
    ApiErrorModel this.error,
  )   : data = null,
        isSuccess = false;
}
