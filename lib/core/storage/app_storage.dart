import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tourguide_app/core/constants/storage_keys.dart';

// Wraps FlutterSecureStorage so the rest of the app never touches it directly.
class AppStorage {
  AppStorage._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // ---------- Auth Token ----------
  static Future<void> saveToken(String token) =>
      _storage.write(key: StorageKeys.authToken, value: token);

  static Future<String?> getToken() =>
      _storage.read(key: StorageKeys.authToken);

  static Future<void> deleteToken() =>
      _storage.delete(key: StorageKeys.authToken);

  // ---------- Guest Token ----------
  static Future<void> saveGuestToken(String token) =>
      _storage.write(key: StorageKeys.guestToken, value: token);

  static Future<String?> getGuestToken() =>
      _storage.read(key: StorageKeys.guestToken);

  // ---------- Device Token (FCM) ----------
  static Future<void> saveDeviceToken(String token) =>
      _storage.write(key: StorageKeys.deviceToken, value: token);

  static Future<String?> getDeviceToken() =>
      _storage.read(key: StorageKeys.deviceToken);

  // ---------- User ID ----------
  static Future<void> saveUserId(String id) =>
      _storage.write(key: StorageKeys.userId, value: id);

  static Future<String?> getUserId() =>
      _storage.read(key: StorageKeys.userId);

  // ---------- Verification Status ----------
  static Future<void> saveVerificationStatus(String status) =>
      _storage.write(key: StorageKeys.verificationStatus, value: status);

  static Future<String?> getVerificationStatus() =>
      _storage.read(key: StorageKeys.verificationStatus);

  // ---------- Clear everything (logout) ----------
  static Future<void> clearAll() => _storage.deleteAll();
}
