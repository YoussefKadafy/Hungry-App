import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/auth/domain/repo/base_auth_repo.dart';

class LoginUseCase {
  final BaseAuthRepo authRepo;
  LoginUseCase(this.authRepo);
  Future<Either<Failure, UserModel?>> call({
    required String email,
    required String password,
  }) => authRepo.login(email: email, password: password);
}

class RegisterUseCase {
  final BaseAuthRepo authRepo;
  RegisterUseCase(this.authRepo);
  Future<Either<Failure, UserModel?>> call({
    required String name,
    required String email,
    required String password,
  }) => authRepo.register(name: name, email: email, password: password);
}
