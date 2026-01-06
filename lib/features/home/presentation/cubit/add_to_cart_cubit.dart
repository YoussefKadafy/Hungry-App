import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/home/domain/use_cases/add_to_cart_use_case.dart';
import 'package:hungry/features/home/presentation/cubit/add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final AddToCartUseCase useCase;
  AddToCartCubit(this.useCase) : super(AddToCartInitial());

  final List<int> _toppingsId = [];
  final List<int> _optionsId = [];
  double _spiceLevel = 0.1;
  double get spiceLevel => _spiceLevel;
  List<int> get toppingsId => _toppingsId;
  List<int> get optionsId => _optionsId;

  Future<void> addToCart(CartRequestModel request) async {
    if (isClosed) return;
    emit(AddToCartLoading());
    final result = await useCase.call(request);
    result.fold(
      (failure) => emit(AddToCartError(message: failure.toString())),
      (cart) => emit(AddToCartSuccess(addToCartResponseModel: cart)),
    );
    clearSelections();
  }

  void addToppingsId(int id) {
    if (isClosed) return;
    if (_toppingsId.contains(id)) {
      _toppingsId.remove(id);
    } else {
      _toppingsId.add(id);
    }
    emit(AddToCartInitial());
  }

  void addOptionsId(int id) {
    if (isClosed) return;
    if (_optionsId.contains(id)) {
      _optionsId.remove(id);
    } else {
      _optionsId.add(id);
    }
    emit(AddToCartInitial());
  }

  void clearSelections() {
    _toppingsId.clear();
    _optionsId.clear();
    _spiceLevel = 0.1;
    emit(AddToCartInitial());
  }

  void spiceLevelChanged(double value) {
    if (isClosed) return;
    _spiceLevel = value;
    emit(AddToCartInitial());
  }
}
