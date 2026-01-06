import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<UserModel?> login({required String email, required String password});
  Future<void> logout();

  Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  final ApiServices apiServices;

  AuthRemoteDataSource(this.apiServices);
  @override
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    final response = await apiServices.post('/login', {
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
  }

  @override
  Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await apiServices.post('/register', {
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
  }

  @override
  Future<void> logout() async {
    await apiServices.post('/logout', {});
    await PrefHelper.removeToken();
  }
}
