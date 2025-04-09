import 'package:eurovision_app/app/features/data/datasources/local/test_local_datasource.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/test_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/models/test_model.dart';
import 'package:eurovision_app/core/logger/app_logger.dart';
import 'package:eurovision_app/core/result/result.dart';

abstract class TestRepository {
  Future<DataResult<TestModel>> getById({
    required String id,
  });
  Future<DataResult<List<TestModel>>> getAll();
  Future<Result> create({
    required TestModel testModel,
  });
}

class TestRepositoryImpl implements TestRepository {
  final TestRemoteDatasource _remoteDatasource;
  final TestLocalDatasource _localDatasource;

  TestRepositoryImpl({
    required TestRemoteDatasource remoteDatasource,
    required TestLocalDatasource localDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  @override
  Future<Result> create({
    required TestModel testModel,
  }) async {
    var apiResponseModel = await _remoteDatasource.create(testModel: testModel);
    if (!apiResponseModel.isSuccess) {
      AppLogger.instance.error(
          "$runtimeType create() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
      return ErrorResult(
          message:
              "$runtimeType create() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
    }
    AppLogger.instance.log("$runtimeType create() SUCCESS");
    return SuccessResult(message: "$runtimeType create()");
  }

  @override
  Future<DataResult<List<TestModel>>> getAll() async {
    var apiResponseModel = await _remoteDatasource.getAll();
    if (!apiResponseModel.isSuccess) {
      AppLogger.instance.error(
          "$runtimeType getAll() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
      return ErrorDataResult(
          message:
              "$runtimeType getAll() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
    }
    if (apiResponseModel.data == null) {
      AppLogger.instance.error("$runtimeType getAll() Null Data");
      return ErrorDataResult(message: "$runtimeType getAll() Null Data");
    }
    AppLogger.instance.log("$runtimeType getAll() SUCCESS");
    return SuccessDataResult(
        data: apiResponseModel.data!, message: "$runtimeType getAll()");
  }

  @override
  Future<DataResult<TestModel>> getById({
    required String id,
  }) async {
    var testModel = await _localDatasource.getById(id: id);
    var apiResponseModel = await _remoteDatasource.getById(id: id);
    if (!apiResponseModel.isSuccess) {
      AppLogger.instance.error(
          "$runtimeType getById() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
      return ErrorDataResult(
          message:
              "$runtimeType getById() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
    }
    if (apiResponseModel.data == null) {
      // AppLogger.instance.error("$runtimeType getById() Null Data");
      // return ErrorDataResult(message: "$runtimeType getById() Null Data");
      AppLogger.instance
          .log("$runtimeType getById() SUCCESS but [Null remote data]");
      return SuccessDataResult(
          data: testModel,
          message: "$runtimeType getById() [Null remote data]");
    }
    AppLogger.instance.log("$runtimeType getById() SUCCESS");
    return SuccessDataResult(
        data: apiResponseModel.data!, message: "$runtimeType getById()");
  }
}