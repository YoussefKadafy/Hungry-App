import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/profile/data/data_source/profile_data_source.dart';
import 'package:hungry/features/profile/domain/repo/base_update_profile_repo.dart';

class UpdateProfileRepo extends BaseUpdateProfileRepo {
  final BaseProfileDataSource dataSource;

  UpdateProfileRepo(this.dataSource);

  @override
  Future<Either<Failure, UserModel>> updateProfile({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? image,
    String? phone,
  }) async {
    try {
      final result = await dataSource.updateProfile(
        name: name,
        email: email,
        address: address,
        visa: visa,
        image: image,
        phone: phone,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
