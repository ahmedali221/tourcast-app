import 'package:dio/dio.dart';
import 'package:tourguide_app/features/notifications/model/notification_model.dart';
import 'package:tourguide_app/features/notifications/repository/i_notifications_repository.dart';

class NotificationsRepository implements INotificationsRepository {
  final Dio _dio;

  NotificationsRepository(this._dio);

  @override
  Future<List<NotificationModel>> getNotifications({int page = 1}) async {
    final response = await _dio.get('/guide/notifications', queryParameters: {'page': page});
    final list = response.data['data'] as List;
    return list.map((e) => NotificationModel.fromJson(e)).toList();
  }

  @override
  Future<void> markAsRead(int notificationId) async {
    await _dio.patch('/guide/notifications/$notificationId/read');
  }

  @override
  Future<void> markAllAsRead() async {
    await _dio.patch('/guide/notifications/read-all');
  }
}
