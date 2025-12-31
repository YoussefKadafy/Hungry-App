import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/features/home/data/model/category_model.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/model/toppings_model.dart';
import 'package:hungry/features/home/data/remote_data_source/remote_data_source.dart';
import 'package:hungry/features/home/domain/repo/base_home_repo.dart';

class HomeRepo extends BaseHomeRepo {
  final BaseRemoteDataSource remoteDataSource;

  HomeRepo(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> fetchAllProducts() async {
    try {
      List<ProductModel> products = await remoteDataSource.fetchAllProducts();
      return Right(products);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategories() async {
    try {
      List<CategoryModel> categories = await remoteDataSource.fetchCategories();
      return Right(categories);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ToppingsModel>>> fetchSideOptions() async {
    try {
      List<ToppingsModel> toppings = await remoteDataSource.fetchSideOptions();
      return Right(toppings);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ToppingsModel>>> fetchToppings() async {
    try {
      List<ToppingsModel> toppings = await remoteDataSource.fetchToppings();
      return Right(toppings);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
