import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/home/domain/use_cases/home_use_cases.dart';
import 'package:hungry/features/home/presentation/cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final HomeUseCases homeUseCases;

  CategoryCubit({required this.homeUseCases}) : super(CategoryInitial());

  Future<void> getCategories() async {
    emit(CategoryLoading());

    final result = await homeUseCases.fetchCategories();

    result.fold((failure) => emit(CategoryError(failure.toString())), (
      categories,
    ) {
      final selectedIndex = state is CategorySuccess
          ? (state as CategorySuccess).selectedIndex
          : 0;

      emit(
        CategorySuccess(selectedIndex: selectedIndex, categories: categories),
      );
    });
  }

  void selectCategory(int index) {
    if (state is CategorySuccess) {
      final currentState = state as CategorySuccess;
      emit(currentState.copyWith(selectedIndex: index));
    }
  }
}
