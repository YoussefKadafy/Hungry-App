import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/profile/domain/repo/base_update_profile_repo.dart';

class UpdateProfileUseCase {
  final BaseUpdateProfileRepo repo;

  UpdateProfileUseCase(this.repo);

  Future<Either<Failure, UserModel>> call({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? image,
    String? phone,
  }) => repo.updateProfile(
    name: name,
    email: email,
    address: address,
    visa: visa,
    image: image,
    phone: phone,
  );
}
