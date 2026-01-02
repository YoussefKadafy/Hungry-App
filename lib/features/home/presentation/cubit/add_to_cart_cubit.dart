import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/home/domain/use_cases/add_to_cart_use_case.dart';
import 'package:hungry/features/home/presentation/cubit/add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final AddToCartUseCase useCase;
  AddToCartCubit(this.useCase) : super(AddToCartInitial());
  Future<void> addToCart(CartRequestModel request) async {
    emit(AddToCartLoading());
    final result = await useCase.call(request);
    result.fold(
      (failure) => emit(AddToCartError(message: failure.toString())),
      (cart) => emit(AddToCartSuccess(addToCartResponseModel: cart)),
    );
  }
}
