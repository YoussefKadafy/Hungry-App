import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/profile/domain/use_case/profile_use_case.dart';
import 'package:hungry/features/profile/presentation/cubit/get_profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileUseCase useCase;

  ProfileCubit(this.useCase) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await useCase.getProfile();
    result.fold(
      (failure) => emit(ProfileError(failure.toString())),
      (user) => emit(ProfileSuccess(user)),
    );
  }
}
