import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/orderHistory/data/model/order_history_model.dart';

abstract class BaseOrderHistoryRemoteDataSource {
  Future<OrderHistoryModel> fetchOrderHistory();
}

class OrdersHistoryRemoteDataSource extends BaseOrderHistoryRemoteDataSource {
  final ApiServices apiServices;

  OrdersHistoryRemoteDataSource(this.apiServices);

  @override
  Future<OrderHistoryModel> fetchOrderHistory() async {
    final response = await apiServices.get('/orders');
    return OrderHistoryModel.fromJson(response);
  }
}
