import 'package:dio/dio.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await PrefHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );
    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get dio => _dio;
}
