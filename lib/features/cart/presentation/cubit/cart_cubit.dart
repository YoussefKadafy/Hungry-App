import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/utils/show_Dialog.dart';
import 'package:hungry/features/cart/data/models/cart_model/cart_model.dart';
import 'package:hungry/features/cart/domain/use_cases/cart_use_case.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartUseCase) : super(CartInitial());
  final CartUseCase cartUseCase;
  String _message = '';
  bool _reloaded = false;
  Map<int, int> _localQuantities = {};

  bool get reloaded => _reloaded;
  String get message => _message;
  Future<void> getCart() async {
    final cart = await cartUseCase.getCartItems();

    cart.fold(
      (failure) => emit(CartError(message: failure.toString())),
      (cart) => emit(CartSuccess(cartModel: cart)),
    );
  }

  Future<void> removeItem({required int id}) async {
    final currentState = state;
    if (currentState is CartSuccess) {
      emit(CartSuccess(cartModel: currentState.cartModel, removingId: id));
    }
    final response = await cartUseCase.removeItemFromCart(id: id);

    response.fold((failure) => _message = failure.toString(), (message) async {
      _message = message;
      await getCart();
      _reloaded = true;
    });
  }

  void _intializeLocalQuantities(CartModel cartModel) {
    _localQuantities.clear();
    final items = cartModel.data?.items ?? [];
    for (var item in items) {
      _localQuantities[item.itemId ?? 0] = item.quantity ?? 1;
    }
  }

  void increaseQuantity(int id) {
    final currentState = state;
    if (currentState is CartSuccess) {
      _localQuantities[id] = (_localQuantities[id] ?? 1) + 1;
      emit(CartSuccess(cartModel: currentState.cartModel));
    }
  }

  void decreaseQuantity(int id) {
    final currentState = state;
    if (currentState is CartSuccess) {
      int currentQty = _localQuantities[id] ?? 1;
      if (currentQty > 1) {
        _localQuantities[id] = currentQty - 1;
        emit(CartSuccess(cartModel: currentState.cartModel));
      }
    }
  }

  int getQuantity(int id) {
    return _localQuantities[id] ?? 1;
  }

  double calculateTotalPrice({required CartModel? cartModel}) {
    final items = cartModel?.data?.items ?? [];
    return items.fold(0.0, (sum, item) {
      double price = double.tryParse(item.price?.toString() ?? '0') ?? 0.0;
      int quantity = getQuantity(item.itemId ?? 0);
      return sum + (price * quantity);
    });
  }
}
