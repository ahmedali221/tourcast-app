import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/notifications/model/notification_model.dart';
import 'package:tourguide_app/features/notifications/repository/i_notifications_repository.dart';

// ---------- States ----------

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> notifications;
  NotificationsLoaded(this.notifications);
}

class NotificationsError extends NotificationsState {
  final String? message;
  NotificationsError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class NotificationsCubit extends Cubit<NotificationsState> {
  final INotificationsRepository _repository;

  NotificationsCubit(this._repository) : super(NotificationsInitial());

  Future<void> loadNotifications({
    int page = 1,
    List<int> markReadIds = const [],
  }) async {
    if (isClosed) return;
    emit(NotificationsLoading());
    try {
      final notifications = await _repository.getNotifications(
        page: page,
        markReadIds: markReadIds,
      );
      if (!isClosed) emit(NotificationsLoaded(notifications));
    } on DioException catch (e) {
      if (!isClosed) emit(NotificationsError(e.response?.data['message']));
    } catch (_) {
      if (!isClosed) emit(NotificationsError(null));
    }
  }

  Future<void> markAsRead(List<int> ids) async {
    if (isClosed || ids.isEmpty) return;
    await loadNotifications(markReadIds: ids);
  }

  Future<void> markAllAsRead() async {
    if (isClosed) return;
    try {
      await _repository.markAllAsRead();
      await loadNotifications();
    } on DioException catch (e) {
      if (!isClosed) emit(NotificationsError(e.response?.data['message']));
    } catch (_) {
      if (!isClosed) emit(NotificationsError(null));
    }
  }
}
