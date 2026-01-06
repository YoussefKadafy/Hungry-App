import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseAuthRepo {
  Future<Either<Failure, UserModel?>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel?>> register({
    required String name,
    required String email,
    required String password,
  });
}
