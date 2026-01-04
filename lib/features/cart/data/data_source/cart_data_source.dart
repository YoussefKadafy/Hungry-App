import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/cart/data/models/cart_model/cart_model.dart';

abstract class BaseRemouteCartDataSource {
  Future<CartModel> getCartItems();
  Future<String> removeItemFromCart(int itemId);
  Future<String> saveOrder(CartRequestModel request);
}

class RemouteCartDataSource extends BaseRemouteCartDataSource {
  RemouteCartDataSource(this.apiServices);
  final ApiServices apiServices;

  @override
  Future<CartModel> getCartItems() async {
    final response = await apiServices.get('/cart');
    return CartModel.fromJson(response);
  }

  @override
  Future<String> removeItemFromCart(int itemId) async {
    final response = await apiServices.delete('/cart/remove/$itemId');
    return response['message'];
  }

  @override
  Future<String> saveOrder(CartRequestModel request) async {
    final response = await apiServices.post('/orders', request.toJson());
    return response['message'];
  }
}
