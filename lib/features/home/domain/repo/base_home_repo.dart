import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/home/data/model/category_model.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/model/toppings_model.dart';

abstract class BaseHomeRepo {
  Future<Either<Failure, List<CategoryModel>>> fetchCategories();
  Future<Either<Failure, List<ProductModel>>> fetchAllProducts();
  Future<Either<Failure, List<ToppingsModel>>> fetchToppings();
  Future<Either<Failure, List<ToppingsModel>>> fetchSideOptions();
}
