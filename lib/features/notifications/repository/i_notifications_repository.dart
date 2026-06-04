import 'package:tourguide_app/features/notifications/model/notification_model.dart';

abstract class INotificationsRepository {
  Future<List<NotificationModel>> getNotifications({
    int page = 1,
    List<int> markReadIds = const [],
  });

  Future<void> markAllAsRead();
}
