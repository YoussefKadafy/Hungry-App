import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/home/data/remote_data_source/remote_data_source.dart';

class AddToCartRepo {
  final BaseHomeRemoteDataSource remoteDataSource;

  AddToCartRepo(this.remoteDataSource);

  Future<Either<Failure, AddToCartResponseModel>> addToCart(
    CartRequestModel request,
  ) async {
    try {
      AddToCartResponseModel response = await remoteDataSource.addToCart(
        request,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
