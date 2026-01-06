import 'package:hungry/features/orderHistory/data/model/order_history_model.dart';

abstract class OrderHistoryStates {}

class OrderHistoryInitial extends OrderHistoryStates {}

class OrderHistoryLoading extends OrderHistoryStates {}

class OrderHistoryError extends OrderHistoryStates {
  final String message;
  OrderHistoryError(this.message);
}

class OrderHistorySuccess extends OrderHistoryStates {
  final OrderHistoryModel orderHistoryModel;
  OrderHistorySuccess(this.orderHistoryModel);
}
