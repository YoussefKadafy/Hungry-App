import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:hungry/features/auth/presentation/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.loginUseCase, required this.registerUseCase})
    : super(AuthInitial());

  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    final result = await loginUseCase(email: email, password: password);

    result.fold(
      (failure) {
        emit(AuthError(failure.toString()));
      },
      (user) {
        if (user != null) {
          emit(AuthSuccess(user));
        } else {
          emit(AuthError('User data is empty'));
        }
      },
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await registerUseCase(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        emit(AuthError(failure.toString()));
      },
      (user) {
        if (user != null) {
          emit(AuthSuccess(user));
        } else {
          emit(AuthError('User data is empty'));
        }
      },
    );
  }
}
