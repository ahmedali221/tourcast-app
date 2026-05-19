class StorageKeys {
  StorageKeys._();

  // ---------- Auth (flutter_secure_storage) ----------
  static const String authToken = 'auth_token';
  static const String guestToken = 'guest_token';
  static const String deviceToken = 'device_token';
  static const String userId = 'user_id';
  static const String verificationStatus = 'verification_status';

  // ---------- Cache (SharedPreferences) ----------
  // All cache keys MUST start with 'cache_' so CacheService.clearAll() picks them up.
  static const String profileCache = 'cache_profile';
  static const String verificationCache = 'cache_verification';
  static const String marketplaceAppsCache = 'cache_marketplace_apps';
  static const String announcementsCache = 'cache_announcements';
}

class CacheTTL {
  CacheTTL._();

  static const Duration profile = Duration(hours: 1);
  static const Duration verification = Duration(hours: 24);
  static const Duration marketplaceApps = Duration(hours: 6);
  static const Duration announcements = Duration(minutes: 30);
}
