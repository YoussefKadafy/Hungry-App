import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/profile/data/data_source/profile_data_source.dart';
import 'package:hungry/features/profile/domain/repo/base_profile_repo.dart';

class ProfileRepo extends BaseProfileRepo {
  final BaseProfileDataSource remoteDataSource;
  ProfileRepo(this.remoteDataSource);

  @override
  Future<Either<Failure, UserModel>> getProfile() async {
    try {
      final response = await remoteDataSource.getProfile();
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
