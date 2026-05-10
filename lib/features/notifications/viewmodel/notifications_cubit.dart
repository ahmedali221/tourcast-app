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
  final String message;
  NotificationsError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class NotificationsCubit extends Cubit<NotificationsState> {
  final INotificationsRepository _repository;

  NotificationsCubit(this._repository) : super(NotificationsInitial());

  Future<void> loadNotifications({int page = 1}) async {
    emit(NotificationsLoading());
    try {
      final notifications = await _repository.getNotifications(page: page);
      emit(NotificationsLoaded(notifications));
    } on DioException catch (e) {
      emit(NotificationsError(e.response?.data['message'] ?? 'Failed to load notifications'));
    } catch (_) {
      emit(NotificationsError('Something went wrong. Please try again.'));
    }
  }

  Future<void> markAsRead(int notificationId) async {
    try {
      await _repository.markAsRead(notificationId);
      // optimistically reload
      await loadNotifications();
    } on DioException catch (e) {
      emit(NotificationsError(e.response?.data['message'] ?? 'Failed to mark as read'));
    } catch (_) {
      emit(NotificationsError('Something went wrong. Please try again.'));
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _repository.markAllAsRead();
      await loadNotifications();
    } on DioException catch (e) {
      emit(NotificationsError(e.response?.data['message'] ?? 'Failed to mark all as read'));
    } catch (_) {
      emit(NotificationsError('Something went wrong. Please try again.'));
    }
  }
}
