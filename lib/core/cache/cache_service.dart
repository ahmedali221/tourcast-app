import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  CacheService._();

  static const String _ttlSuffix = '_ttl';

  static Future<void> set(String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data));
    await prefs.setInt('$key$_ttlSuffix', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<void> setList(String key, List<Map<String, dynamic>> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data));
    await prefs.setInt('$key$_ttlSuffix', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<Map<String, dynamic>?> get(String key, {required Duration ttl}) async {
    final raw = await _getRaw(key, ttl: ttl);
    if (raw == null) return null;
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) return null;
    return decoded;
  }

  static Future<List<Map<String, dynamic>>?> getList(String key, {required Duration ttl}) async {
    final raw = await _getRaw(key, ttl: ttl);
    if (raw == null) return null;
    final decoded = jsonDecode(raw);
    if (decoded is! List) return null;
    return decoded.cast<Map<String, dynamic>>();
  }

  static Future<void> invalidate(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await prefs.remove('$key$_ttlSuffix');
  }

  /// Removes all keys that start with 'cache_' (all cache entries and their TTL keys).
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    for (final key in prefs.getKeys().where((k) => k.startsWith('cache_')).toList()) {
      await prefs.remove(key);
    }
  }

  static Future<String?> _getRaw(String key, {required Duration ttl}) async {
    final prefs = await SharedPreferences.getInstance();
    final savedAt = prefs.getInt('$key$_ttlSuffix');
    if (savedAt == null) return null;
    final age = DateTime.now().millisecondsSinceEpoch - savedAt;
    if (age > ttl.inMilliseconds) return null;
    return prefs.getString(key);
  }
}
