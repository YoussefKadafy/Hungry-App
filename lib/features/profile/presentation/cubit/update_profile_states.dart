import 'package:hungry/features/auth/data/model/user_model.dart';

abstract class UpdateProfileStates {}

class UpdateProfileInitial extends UpdateProfileStates {}

class UpdateProfileLoading extends UpdateProfileStates {}

class UpdateProfileError extends UpdateProfileStates {
  final String message;
  UpdateProfileError({required this.message});
}

class UpdateProfileSuccess extends UpdateProfileStates {
  final UserModel userModel;
  UpdateProfileSuccess({required this.userModel});
}
