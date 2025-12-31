import 'package:hungry/features/home/data/model/category_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryModel> categories;
  final int selectedIndex;

  CategorySuccess({required this.categories, this.selectedIndex = 0});

  CategorySuccess copyWith({
    List<CategoryModel>? categories,
    int? selectedIndex,
  }) {
    return CategorySuccess(
      categories: categories ?? this.categories,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}
