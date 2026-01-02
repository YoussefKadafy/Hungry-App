import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/home/data/model/toppings_model.dart';
import 'package:hungry/features/home/domain/use_cases/toppings_and_options_use_case.dart';
import 'package:hungry/features/home/presentation/cubit/toppins_and_options_states.dart';

class ToppinsAndOptionsCubit extends Cubit<ToppingsAndOptionsStates> {
  final ToppingsAndOptionsUseCase useCase;

  ToppinsAndOptionsCubit(this.useCase) : super(ToppingsAndOptionsInitial());

  List<ToppingsModel> _toppings = [];
  List<ToppingsModel> _options = [];

  List<ToppingsModel> get toppings => _toppings;
  List<ToppingsModel> get options => _options;

  Future<void> fetchToppings() async {
    emit(ToppingsAndOptionsLoading());

    final result = await useCase.fetchToppings();
    result.fold(
      (failure) => emit(ToppingsAndOptionsError(failure.toString())),
      (toppings) {
        _toppings = toppings;
        emit(ToppingsAndOptionsSuccess());
      },
    );
  }

  Future<void> fetchSideOptions() async {
    emit(ToppingsAndOptionsLoading());

    final result = await useCase.fetchSideOptions();
    result.fold(
      (failure) => emit(ToppingsAndOptionsError(failure.toString())),
      (options) {
        _options = options;
        emit(ToppingsAndOptionsSuccess());
      },
    );
  }
}
