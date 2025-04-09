part of 'result.dart';

class SuccessDataResult<T> extends DataResult<T> {
  SuccessDataResult({String? message = "Success", required T data})
      : super(true, message!, data);
}
