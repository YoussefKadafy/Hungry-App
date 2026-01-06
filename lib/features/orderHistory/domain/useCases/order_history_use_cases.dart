import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/orderHistory/data/model/order_history_model.dart';
import 'package:hungry/features/orderHistory/domain/repo/base_order_history_repo.dart';

class OrderHistoryUseCases {
  final BaseOrderHistoryRepo repo;

  OrderHistoryUseCases(this.repo);

  Future<Either<Failure, OrderHistoryModel>> fetchOrderHistory() =>
      repo.fetchOrderHistory();
}
