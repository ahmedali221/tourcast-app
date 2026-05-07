import 'package:flutter_bloc/flutter_bloc.dart';

// ---------- States ----------
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// ---------- Cubit (ViewModel) ----------
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    // TODO: implement login
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    // TODO: implement register
  }

  Future<void> logout() async {
    // TODO: implement logout
  }
}
