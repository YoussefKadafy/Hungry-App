import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/home/data/model/category_model.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/model/toppings_model.dart';

abstract class BaseHomeRemoteDataSource {
  Future<List<ProductModel>> fetchAllProducts();
  Future<List<CategoryModel>> fetchCategories();
  Future<List<ToppingsModel>> fetchToppings();
  Future<List<ToppingsModel>> fetchSideOptions();
}

class RemoteHomeDataSource extends BaseHomeRemoteDataSource {
  final ApiServices apiServices;

  RemoteHomeDataSource(this.apiServices);
  @override
  Future<List<ProductModel>> fetchAllProducts() async {
    final response = await apiServices.get('/products');
    final List data = response['data'];
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await apiServices.get('/categories');
    final List data = response['data'];
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }

  @override
  Future<List<ToppingsModel>> fetchSideOptions() async {
    final response = await apiServices.get('/side-options');
    final List data = response['data'];
    return data.map((json) => ToppingsModel.fromJson(json)).toList();
  }

  @override
  Future<List<ToppingsModel>> fetchToppings() async {
    final response = await apiServices.get('/toppings');
    final List data = response['data'];
    return data.map((json) => ToppingsModel.fromJson(json)).toList();
  }
}
