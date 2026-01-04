import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/features/cart/data/data_source/cart_data_source.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/cart/data/models/cart_model/cart_model.dart';
import 'package:hungry/features/cart/domain/repo/base_cart_repo.dart';

class CartRepo extends BaseCartRepo {
  final BaseRemouteCartDataSource remouteCartDataSource;

  CartRepo(this.remouteCartDataSource);
  @override
  Future<Either<Failure, CartModel>> getCartItems() async {
    try {
      final response = await remouteCartDataSource.getCartItems();
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> removeItemFromCart({required int id}) async {
    try {
      final response = await remouteCartDataSource.removeItemFromCart(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveOrder({
    required CartRequestModel request,
  }) async {
    try {
      final response = remouteCartDataSource.saveOrder(request);
      return Right(response.toString());
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
