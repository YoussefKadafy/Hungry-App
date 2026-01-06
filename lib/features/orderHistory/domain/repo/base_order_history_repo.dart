import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/orderHistory/data/model/order_history_model.dart';

abstract class BaseOrderHistoryRepo {
  Future<Either<Failure, OrderHistoryModel>> fetchOrderHistory();
}
