import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/core/storage/app_storage.dart';
import 'package:tourguide_app/features/auth/repository/i_auth_repository.dart';

// ---------- States ----------

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthEmailSent extends AuthState {} // for forgot password success

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository _repository;

  AuthCubit(this._repository) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await _repository.login(email, password);
      await AppStorage.saveToken(result.token);
      emit(AuthSuccess());
    } on DioException catch (e) {
      emit(AuthError(e.response?.data['message'] ?? 'Login failed'));
    } catch (_) {
      emit(AuthError('Something went wrong. Please try again.'));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? referralCode,
  }) async {
    emit(AuthLoading());
    try {
      final result = await _repository.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        referralCode: referralCode,
      );
      await AppStorage.saveToken(result.token);
      emit(AuthSuccess());
    } on DioException catch (e) {
      emit(AuthError(e.response?.data['message'] ?? 'Registration failed'));
    } catch (_) {
      emit(AuthError('Something went wrong. Please try again.'));
    }
  }

  Future<void> logout() async {
    try {
      await _repository.logout();
    } catch (_) {
    } finally {
      await AppStorage.clearAll();
      emit(AuthInitial());
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    emit(AuthLoading());
    try {
      await _repository.sendPasswordResetEmail(email);
      emit(AuthEmailSent());
    } on DioException catch (e) {
      emit(
        AuthError(e.response?.data['message'] ?? 'Failed to send reset email'),
      );
    } catch (_) {
      emit(AuthError('Something went wrong. Please try again.'));
    }
  }

  Future<void> resendVerificationEmail() async {
    emit(AuthLoading());
    try {
      await _repository.resendVerificationEmail();
      emit(AuthEmailSent());
    } on DioException catch (e) {
      emit(AuthError(e.response?.data['message'] ?? 'Failed to resend email'));
    } catch (_) {
      emit(AuthError('Something went wrong. Please try again.'));
    }
  }
}
