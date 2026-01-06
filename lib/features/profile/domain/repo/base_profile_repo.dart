import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';

abstract class BaseProfileRepo {
  Future<Either<Failure, UserModel>> getProfile();
}
