import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';

abstract class BaseProfileDataSource {
  Future<UserModel> getProfile();
  Future<UserModel> updateProfile({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? image,
    String? phone,
  });
}

class ProfileDataSource extends BaseProfileDataSource {
  final ApiServices apiServices;

  ProfileDataSource(this.apiServices);

  @override
  Future<UserModel> getProfile() async {
    final response = await apiServices.get('/profile');
    return UserModel.fromJson(response['data']);
  }

  @override
  Future<UserModel> updateProfile({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? image,
    String? phone,
  }) async {
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
    final response = await apiServices.post('/update-profile', formData);
    return UserModel.fromJson(response['data']);
  }
}
