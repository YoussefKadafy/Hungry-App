import 'package:hungry/features/auth/data/model/user_model.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class ProfileSuccess extends ProfileStates {
  final UserModel userModel;

  ProfileSuccess(this.userModel);
}

class ProfileError extends ProfileStates {
  final String message;

  ProfileError(this.message);
}

class ProfileLoading extends ProfileStates {}
