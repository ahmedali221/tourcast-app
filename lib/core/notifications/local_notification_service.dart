import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourguide_app/core/sync/sync_keys.dart';

// Called when user taps a notification while the app is killed.
// Must be top-level and annotated so it survives tree-shaking.
@pragma('vm:entry-point')
void onBackgroundNotificationResponse(NotificationResponse response) async {
  final route = response.payload;
  if (route == null || route.isEmpty) return;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(SyncKeys.pendingRoute, route);
}

class LocalNotificationService {
  static const _channelId = 'niletech_sync';
  static const _channelName = 'NileTech Updates';

  final _plugin = FlutterLocalNotificationsPlugin();
  final _tapController = StreamController<String>.broadcast();

  Stream<String> get onTap => _tapController.stream;

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: _onTap,
      onDidReceiveBackgroundNotificationResponse: onBackgroundNotificationResponse,
    );

    // Create the Android notification channel.
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            _channelId,
            _channelName,
            description: 'Background sync notifications for tickets and updates',
            importance: Importance.high,
          ),
        );

    // Check if app was launched from a background tap that happened while killed.
    // The onBackgroundNotificationResponse handler already stored the route in
    // SharedPreferences — read and cache it here for consumePendingRoute().
    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp == true) {
      final payload = launchDetails?.notificationResponse?.payload;
      if (payload != null && payload.isNotEmpty) {
        _pendingRoute = payload;
        // Clear from SharedPreferences — the in-memory value takes over.
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(SyncKeys.pendingRoute);
        return;
      }
    }

    // Fallback: check SharedPreferences (set by onBackgroundNotificationResponse
    // in a previous isolate run that may have finished before this init).
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(SyncKeys.pendingRoute);
    if (stored != null && stored.isNotEmpty) {
      _pendingRoute = stored;
      await prefs.remove(SyncKeys.pendingRoute);
    }
  }

  Future<bool> requestPermission() async {
    if (Platform.isAndroid) {
      final result = await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      return result ?? false;
    } else if (Platform.isIOS) {
      final result = await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return result ?? false;
    }
    return false;
  }

  Future<void> show({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: const AndroidNotificationDetails(
          _channelId,
          _channelName,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  String? _pendingRoute;

  /// Returns the route stored from a cold-start notification tap, then clears it.
  String? consumePendingRoute() {
    final route = _pendingRoute;
    _pendingRoute = null;
    return route;
  }

  void _onTap(NotificationResponse response) {
    final route = response.payload;
    if (route != null && route.isNotEmpty) {
      _tapController.add(route);
    }
  }

  void dispose() {
    _tapController.close();
  }
}
