import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:hungry/features/auth/data/model/logout_response_model.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/auth/domain/repo/base_auth_repo.dart';

class AuthRepo extends BaseAuthRepo {
  final BaseAuthRemoteDataSource remoteDataSource;

  AuthRepo(this.remoteDataSource);

  @override
  Future<Either<Failure, UserModel?>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(user);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
      );
      return Right(user);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LogoutResponseModel>> logout() async {
    try {
      final result = await remoteDataSource.logout();
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
