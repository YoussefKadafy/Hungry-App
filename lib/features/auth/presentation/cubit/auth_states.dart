import 'package:hungry/features/auth/data/model/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthSuccess extends AuthState {
  final UserModel user;
  AuthSuccess(this.user);
}
