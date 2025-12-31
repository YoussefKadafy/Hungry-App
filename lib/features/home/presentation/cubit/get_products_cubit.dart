import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/home/domain/use_cases/home_use_cases.dart';
import 'package:hungry/features/home/presentation/cubit/praducts_state.dart';

class GetProductsCubit extends Cubit<ProductState> {
  final HomeUseCases homeUseCases;

  GetProductsCubit({required this.homeUseCases}) : super(ProductInitial());

  Future<void> getProducts() async {
    emit(ProductLoading());
    final result = await homeUseCases.fetchAllProducts();
    result.fold(
      (failure) => emit(ProductError(failure.toString())),
      (products) => emit(ProductSuccess(products)),
    );
  }
}
