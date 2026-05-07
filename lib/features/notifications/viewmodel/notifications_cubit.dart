import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NotificationsState {}
class NotificationsInitial extends NotificationsState {}
class NotificationsLoading extends NotificationsState {}
class NotificationsLoaded extends NotificationsState {}
class NotificationsError extends NotificationsState {
  final String message;
  NotificationsError(this.message);
}

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  Future<void> loadNotifications() async {}
  Future<void> markAsRead(int id) async {}
  Future<void> markAllAsRead() async {}
}
