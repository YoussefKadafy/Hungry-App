import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/profile/domain/repo/base_profile_repo.dart';

class ProfileUseCase {
  final BaseProfileRepo baseProfileRepo;

  ProfileUseCase(this.baseProfileRepo);

  Future<Either<Failure, UserModel>> getProfile() =>
      baseProfileRepo.getProfile();
}
