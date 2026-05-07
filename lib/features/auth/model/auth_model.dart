// Response model for login / register endpoints.
// POST /api/login  →  { "token": "...", "converted_from_guest_session": false }
class AuthModel {
  final String token;
  final bool convertedFromGuestSession;

  AuthModel({
    required this.token,
    required this.convertedFromGuestSession,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] as String,
      convertedFromGuestSession: json['converted_from_guest_session'] as bool? ?? false,
    );
  }
}
