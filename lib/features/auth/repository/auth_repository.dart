import 'package:dio/dio.dart';
import 'package:tourguide_app/features/auth/model/auth_model.dart';
import 'package:tourguide_app/features/auth/repository/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  @override
  Future<AuthModel> login(String email, String password) async {
    final response = await _dio.post('/login', data: {
      'email': email,
      'password': password,
    });
    return AuthModel.fromJson(response.data);
  }

  @override
  Future<AuthModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await _dio.post('/register', data: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
    return AuthModel.fromJson(response.data);
  }

  @override
  Future<void> logout() async {
    await _dio.post('/guide/logout');
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _dio.post('/forgot-password', data: {'email': email});
  }

  @override
  Future<void> resendVerificationEmail() async {
    await _dio.post('/email/verification-notification');
  }
}
