import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/home/data/model/category_model.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/domain/repo/base_home_repo.dart';

class HomeUseCases {
  final BaseHomeRepo repo;

  HomeUseCases(this.repo);

  Future<Either<Failure, List<CategoryModel>>> fetchCategories() =>
      repo.fetchCategories();

  Future<Either<Failure, List<ProductModel>>> fetchAllProducts() =>
      repo.fetchAllProducts();
}
