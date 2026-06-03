import 'package:dio/dio.dart';
import 'package:tourguide_app/features/notifications/model/notification_model.dart';
import 'package:tourguide_app/features/notifications/repository/i_notifications_repository.dart';

class NotificationsRepository implements INotificationsRepository {
  final Dio _dio;

  NotificationsRepository(this._dio);

  @override
  Future<List<NotificationModel>> getNotifications({
    int page = 1,
    List<int> markReadIds = const [],
  }) async {
    final params = <String, dynamic>{'page': page};
    if (markReadIds.isNotEmpty) {
      params['mark_read[]'] = markReadIds;
    }
    final response = await _dio.get('/guide/notifications', queryParameters: params);
    final raw = response.data['data'];
    final list = (raw is Map ? raw['data'] : raw) as List? ?? [];
    return list.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> markAllAsRead() async {
    await _dio.post('/guide/notifications/mark-all-read');
  }
}
