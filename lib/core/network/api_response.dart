// Standard shape for every API response from the Thoth backend.
// { "message": "...", "data": {...} or [...], "errors": {...} }
class ApiResponse<T> {
  final String? message;
  final T? data;
  final Map<String, dynamic>? errors;

  ApiResponse({this.message, this.data, this.errors});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromData,
  ) {
    return ApiResponse(
      message: json['message'] as String?,
      data: json['data'] != null ? fromData(json['data']) : null,
      errors: json['errors'] as Map<String, dynamic>?,
    );
  }
}
