class SyncKeys {
  SyncKeys._();

  static const String lastNotificationId = 'sync_last_notification_id';
  static const String pendingRoute = 'sync_pending_route';

  static String replyCountKey(int ticketId) =>
      'sync_ticket_${ticketId}_reply_count';

  static String statusKey(int ticketId) => 'sync_ticket_${ticketId}_status';
}
