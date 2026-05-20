import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:tourguide_app/core/sync/sync_keys.dart';

const _channelId = 'niletech_sync';
const _channelName = 'NileTech Updates';
const _baseUrl = 'https://app.niletechdev.com/api';

@pragma('vm:entry-point')
void backgroundSyncDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      // Auth check — skip silently if not logged in.
      const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );
      final token = await storage.read(key: 'auth_token');
      if (token == null) return true;

      // Minimal Dio — no interceptors, no logger (unsafe in background isolate).
      final dio = Dio(BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ));

      // Init flutter_local_notifications for this isolate.
      final plugin = FlutterLocalNotificationsPlugin();
      await plugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        ),
      );

      final prefs = await SharedPreferences.getInstance();

      await _syncTickets(dio, plugin, prefs);
      await _syncNotifications(dio, plugin, prefs);
    } catch (_) {
      // Swallow all errors — returning false causes WorkManager to retry
      // aggressively which would flood the API.
    }
    return true;
  });
}

Future<void> _syncTickets(
  Dio dio,
  FlutterLocalNotificationsPlugin plugin,
  SharedPreferences prefs,
) async {
  final response = await dio.get('/guide/support/tickets');
  final data = response.data['data'];
  if (data is! List) return;

  for (final item in data) {
    final id = (item['id'] as num).toInt();
    final newStatus = (item['status'] as String?) ?? '';
    final messages = item['messages'] as List?;
    final newCount = messages?.length ?? 0;

    final oldStatus = prefs.getString(SyncKeys.statusKey(id));
    final oldCount = prefs.getInt(SyncKeys.replyCountKey(id)) ?? 0;

    // Only fire change notifications after the first sync (baseline established).
    if (oldStatus != null) {
      if (oldStatus != newStatus && newStatus.isNotEmpty) {
        await _show(
          plugin,
          id: id + 10000,
          title: 'Ticket #$id status updated',
          body: 'Status changed to $newStatus',
          payload: '/support/$id',
        );
      } else if (newCount > oldCount) {
        final delta = newCount - oldCount;
        await _show(
          plugin,
          id: id,
          title: 'New reply on Ticket #$id',
          body: '$delta new message${delta > 1 ? 's' : ''}',
          payload: '/support/$id',
        );
      }
    }

    await prefs.setString(SyncKeys.statusKey(id), newStatus);
    await prefs.setInt(SyncKeys.replyCountKey(id), newCount);
  }
}

Future<void> _syncNotifications(
  Dio dio,
  FlutterLocalNotificationsPlugin plugin,
  SharedPreferences prefs,
) async {
  final response =
      await dio.get('/guide/notifications', queryParameters: {'page': 1});

  // API can return {data: [...]} or {data: {data: [...]}} (paginated).
  final rawData = response.data['data'];
  final List items;
  if (rawData is List) {
    items = rawData;
  } else if (rawData is Map && rawData['data'] is List) {
    items = rawData['data'] as List;
  } else {
    return;
  }

  if (items.isEmpty) return;

  final latestId = (items.first['id'] as num).toInt();
  final lastSeenId = prefs.getInt(SyncKeys.lastNotificationId) ?? 0;

  if (latestId > lastSeenId) {
    final newItems =
        items.where((n) => (n['id'] as num).toInt() > lastSeenId).toList();

    if (lastSeenId > 0) {
      // Only notify after baseline is established.
      if (newItems.length == 1) {
        final n = newItems.first;
        await _show(
          plugin,
          id: latestId % 1000,
          title: (n['title'] as String?) ?? 'New notification',
          body: (n['body'] as String?) ?? '',
          payload: '/home/notifications',
        );
      } else {
        await _show(
          plugin,
          id: 9999,
          title: 'NileTech',
          body: 'You have ${newItems.length} new notifications',
          payload: '/home/notifications',
        );
      }
    }

    await prefs.setInt(SyncKeys.lastNotificationId, latestId);
  }
}

Future<void> _show(
  FlutterLocalNotificationsPlugin plugin, {
  required int id,
  required String title,
  required String body,
  required String payload,
}) async {
  await plugin.show(
    id,
    title,
    body,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    ),
    payload: payload,
  );
}
