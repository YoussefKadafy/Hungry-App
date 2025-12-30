import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/network/dio_client.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/cart/data/models/cart_model/cart_model.dart';

class CartRepo {
  final ApiServices _apiServices = ApiServices(DioClient(Dio()));

  Future<CartModel> getCartItems() async {
    try {
      final response = await _apiServices.get('/cart');
      return CartModel.fromJson(response);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<String> removeItemFromCart(int itemId) async {
    try {
      final response = await _apiServices.delete('/cart/remove/$itemId');
      return response['message'];
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<String> saveOrder(CartRequestModel request) async {
    try {
      final response = await _apiServices.post('/orders', request.toJson());
      return response['message'];
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
