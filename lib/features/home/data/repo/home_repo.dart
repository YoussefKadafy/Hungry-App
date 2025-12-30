import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/network/dio_client.dart';
import 'package:hungry/features/home/data/model/category_model.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/model/toppings_model.dart';

class HomeRepo {
  final ApiServices _apiServices = ApiServices(DioClient(Dio()));

  /// fetch categories
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await _apiServices.get('/categories');
    final List data = response['data'];
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }

  /// fetch products by category id
  Future<List<ProductModel>> fetchAllProducts() async {
    final response = await _apiServices.get('/products');
    final List data = response['data'];
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  ///toppings

  Future<List<ToppingsModel>> fetchToppings() async {
    final response = await _apiServices.get('/toppings');
    final List data = response['data'];
    return data.map((json) => ToppingsModel.fromJson(json)).toList();
  }

  ///side Options
  Future<List<ToppingsModel>> fetchSideOptions() async {
    final response = await _apiServices.get('/side-options');
    final List data = response['data'];
    return data.map((json) => ToppingsModel.fromJson(json)).toList();
  }
}
