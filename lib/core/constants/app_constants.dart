class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'NileTech Tour Guide';

  // API Base URLs
  static const String baseUrl = 'https://api.niletech.com';
  static const String apiBase = '$baseUrl/api';
  static const String guideBase = '$baseUrl/api/guide';
  static const String thothBase = '$baseUrl/api/thoth-guide';

  // Timeouts (in seconds)
  static const int connectionTimeout = 30;
  static const int receiveTimeout = 30;

  // Pagination
  static const int pageSize = 15;

  // Photo limits
  static const int maxPhotoSizeBytes = 2 * 1024 * 1024; // 2 MB
}
