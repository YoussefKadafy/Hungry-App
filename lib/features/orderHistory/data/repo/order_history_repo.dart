import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/network/dio_client.dart';
import 'package:hungry/features/orderHistory/data/model/order_history_model.dart';

class OrderHistoryRepo {
  final ApiServices _apiServices = ApiServices(DioClient(Dio()));
  Future<OrderHistoryModel> fetchOrderHistory() async {
    try {
      final response = await _apiServices.get('/orders');
      return OrderHistoryModel.fromJson(response);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
