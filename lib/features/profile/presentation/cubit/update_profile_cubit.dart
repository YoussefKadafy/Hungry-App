import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/profile/domain/use_case/update_profile_use_case.dart';
import 'package:hungry/features/profile/presentation/cubit/update_profile_states.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileStates> {
  final UpdateProfileUseCase useCase;

  UpdateProfileCubit(this.useCase) : super(UpdateProfileInitial());

  Future<void> updateProfile({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? image,
    String? phone,
  }) async {
    emit(UpdateProfileLoading());
    final result = await useCase.call(
      name: name,
      email: email,
      address: address,
      visa: visa,
      image: image,
      phone: phone,
    );
    result.fold(
      (failure) => emit(UpdateProfileError(message: failure.toString())),
      (user) => emit(UpdateProfileSuccess(userModel: user)),
    );
  }
}
