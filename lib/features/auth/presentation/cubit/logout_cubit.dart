import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:hungry/features/auth/presentation/cubit/logout_states.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase useCase;

  LogoutCubit(this.useCase) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    final result = await useCase.call();
    result.fold(
      (failure) => emit(LogoutError(failure.toString())),
      (r) => emit(LogoutSuccess()),
    );
  }
}
