import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/features/orderHistory/data/data_source/orders_history_data_source.dart';
import 'package:hungry/features/orderHistory/data/model/order_history_model.dart';
import 'package:hungry/features/orderHistory/domain/repo/base_order_history_repo.dart';

class OrderHistoryRepo extends BaseOrderHistoryRepo {
  final BaseOrderHistoryRemoteDataSource dataSource;

  OrderHistoryRepo(this.dataSource);

  @override
  Future<Either<Failure, OrderHistoryModel>> fetchOrderHistory() async {
    try {
      final response = await dataSource.fetchOrderHistory();
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
