import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/cart/domain/use_cases/cart_use_case.dart';
import 'package:hungry/features/cart/presentation/cubit/save_orders_states.dart';

class SaveOrdersCubit extends Cubit<SaveOrderStates> {
  final CartUseCase useCase;

  SaveOrdersCubit(this.useCase) : super(SaveOrderInitial());
  Future<void> saveOrder(CartRequestModel request) async {
    emit(SaveOrderLoading());
    final result = await useCase.saveOrder(request: request);
    result.fold(
      (failure) => emit(SaveOrderError(message: failure.toString())),
      (message) => emit(SaveOrderSuccess(message: message.toString())),
    );
  }
}
