import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/cart/data/models/cart_model/cart_model.dart';
import 'package:hungry/features/cart/domain/use_cases/cart_use_case.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartUseCase) : super(CartInitial());

  final CartUseCase cartUseCase;
  final Map<int, int> _localQuantities = {};

  Future<void> getCart() async {
    emit(CartLoading());

    final result = await cartUseCase.getCartItems();
    result.fold((failure) => emit(CartError(message: failure.toString())), (
      cart,
    ) {
      emit(CartSuccess(cartModel: cart, totalPrice: calculateTotalPrice(cart)));
    });
  }

  Future<void> removeItem({required int id}) async {
    final current = state;
    if (current is! CartSuccess) return;

    emit(current.copyWith(removingId: id));

    final response = await cartUseCase.removeItemFromCart(id: id);
    response.fold(
      (failure) {
        emit(current.copyWith(message: failure.toString(), reloaded: true));
      },
      (message) async {
        await getCart();
        emit((state as CartSuccess).copyWith(message: message, reloaded: true));
      },
    );
  }

  void increaseQuantity(int id) {
    if (state is! CartSuccess) return;
    _localQuantities[id] = (_localQuantities[id] ?? 1) + 1;
    _emitUpdatedState();
  }

  void decreaseQuantity(int id) {
    if (state is! CartSuccess) return;
    final qty = _localQuantities[id] ?? 1;
    if (qty > 1) {
      _localQuantities[id] = qty - 1;
      _emitUpdatedState();
    }
  }

  int getQuantity(int id) => _localQuantities[id] ?? 1;

  void _emitUpdatedState() {
    final current = state as CartSuccess;
    emit(current.copyWith(totalPrice: calculateTotalPrice(current.cartModel)));
  }

  double calculateTotalPrice(CartModel cartModel) {
    final items = cartModel.data?.items ?? [];
    return items.fold(0.0, (sum, item) {
      final price = double.tryParse(item.price?.toString() ?? '0') ?? 0.0;
      final quantity = getQuantity(item.itemId ?? 0);
      return sum + (price * quantity);
    });
  }

  void clearReloadFlag() {
    if (state is CartSuccess) {
      emit((state as CartSuccess).copyWith(reloaded: false));
    }
  }
}
