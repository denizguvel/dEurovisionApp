part of 'result.dart';

class ErrorDataResult<T> extends DataResult<T> {
  ErrorDataResult({required String message}) : super(false, message, null);
}
