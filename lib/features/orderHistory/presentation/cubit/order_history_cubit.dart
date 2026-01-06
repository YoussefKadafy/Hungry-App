import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/orderHistory/domain/useCases/order_history_use_cases.dart';
import 'package:hungry/features/orderHistory/presentation/cubit/order_history_states.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryStates> {
  final OrderHistoryUseCases useCases;

  OrderHistoryCubit(this.useCases) : super(OrderHistoryInitial());

  Future<void> fetchOrderHistory() async {
    emit(OrderHistoryLoading());
    final result = await useCases.fetchOrderHistory();
    result.fold(
      (failure) => emit(OrderHistoryError(failure.toString())),
      (model) => emit(OrderHistorySuccess(model)),
    );
  }
}
