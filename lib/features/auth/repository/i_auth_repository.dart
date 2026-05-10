import 'package:tourguide_app/features/auth/model/auth_model.dart';

abstract class IAuthRepository {
  Future<AuthModel> login(String email, String password);

  Future<AuthModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<void> logout();

  Future<void> sendPasswordResetEmail(String email);

  Future<void> resendVerificationEmail();
}
