import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';

abstract class BaseUpdateProfileRepo {
  Future<Either<Failure, UserModel>> updateProfile({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? image,
    String? phone,
  });
}
