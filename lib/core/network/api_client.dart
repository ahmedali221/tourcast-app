import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tourguide_app/core/constants/app_constants.dart';
import 'package:tourguide_app/core/storage/app_storage.dart';

// Single Dio instance used by every service in the app.
class ApiClient {
  ApiClient._();

  static final Dio _dio = _createDio();

  static Dio get dio => _dio;

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiBase,
        connectTimeout: const Duration(seconds: AppConstants.connectionTimeout),
        receiveTimeout: const Duration(seconds: AppConstants.receiveTimeout),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(_authInterceptor());
    dio.interceptors.add(PrettyDioLogger(compact: true, requestBody: true));

    return dio;
  }

  // Attaches the Bearer token to every request automatically.
  static Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await AppStorage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        final guestToken = await AppStorage.getGuestToken();
        if (guestToken != null) {
          options.headers['X-Guest-Token'] = guestToken;
        }

        handler.next(options);
      },
      onError: (error, handler) async {
        // If the server says 401, clear the saved token so the app re-routes to login.
        if (error.response?.statusCode == 401) {
          await AppStorage.deleteToken();
        }
        handler.next(error);
      },
    );
  }
}
