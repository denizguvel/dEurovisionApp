part 'success_result.dart';
part 'error_result.dart';
part 'success_data_result.dart';
part 'error_data_result.dart';
part 'data_result.dart';

abstract class Result {
  bool success;
  String? message;

  Result(this.success, this.message);
}
