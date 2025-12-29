import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';

class AuthRepo {
  final ApiServices _apiServices = ApiServices();

  /// Login
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiServices.post('/login', {
        'email': email,
        'password': password,
      });
      if (response['data'] == null) {
        throw ApiError(message: response['message']);
      }
      final user = UserModel.fromJson(response['data']);
      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Register

  Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiServices.post('/register', {
        'name': name,
        'email': email,
        'password': password,
      });
      if (response['data'] == null) {
        throw ApiError(message: response['message']);
      }
      final user = UserModel.fromJson(response['data']);
      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// get user profile
  Future<UserModel?> getProfile() async {
    try {
      final response = await _apiServices.get('/profile');
      if (response['data'] == null) {
        throw ApiError(message: response['message']);
      }
      final user = UserModel.fromJson(response['data']);
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// edite user data

  Future<UserModel?> editUserData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        "email": email,
        "address": address,
        if (visa != null && visa.isNotEmpty) "Visa": visa,
        if (image != null && image.isNotEmpty)
          "image": await MultipartFile.fromFile(
            image,
            filename: image.split('/').last,
          ),
        "name": name,
      });
      final response = await _apiServices.post('/update-profile', formData);
      if (response['data'] == null) {
        throw ApiError(message: response['message']);
      }
      final user = UserModel.fromJson(response['data']);
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _apiServices.post('/logout', {});
      await PrefHelper.removeToken();
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
