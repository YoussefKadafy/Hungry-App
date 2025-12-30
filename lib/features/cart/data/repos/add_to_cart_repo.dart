import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/network/dio_client.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';

class AddToCartRepo {
  final ApiServices _apiServices = ApiServices(DioClient(Dio()));
  Future<AddToCartResponseModel> addToCart(CartRequestModel request) async {
    try {
      final response = await _apiServices.post('/cart/add', request.toJson());
      return AddToCartResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
