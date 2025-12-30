import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/dio_client.dart';

class ApiServices {
  final DioClient dioClient;

  ApiServices(this.dioClient);

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await dioClient.dio.get(endpoint);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    try {
      final response = await dioClient.dio.post(endpoint, data: data);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await dioClient.dio.put(endpoint, data: data);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await dioClient.dio.delete(endpoint);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
}
