import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/notifications/model/notification_model.dart';
import 'package:tourguide_app/features/notifications/viewmodel/notifications_cubit.dart';

// Shows a slide-down overlay tray anchored below the app bar.
// Must be called from within a widget that has NotificationsCubit in scope.
void showNotificationsTray(BuildContext context) {
  final overlay = Overlay.of(context);
  final cubit = context.read<NotificationsCubit>();
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: _NotificationsTray(onDismiss: () => entry.remove()),
    ),
  );

  overlay.insert(entry);
}

class _NotificationsTray extends StatefulWidget {
  final VoidCallback onDismiss;
  const _NotificationsTray({required this.onDismiss});

  @override
  State<_NotificationsTray> createState() => _NotificationsTrayState();
}

class _NotificationsTrayState extends State<_NotificationsTray>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.5)),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        // Scrim — tap outside to dismiss
        FadeTransition(
          opacity: _fadeAnim,
          child: GestureDetector(
            onTap: _dismiss,
            behavior: HitTestBehavior.opaque,
            child: Container(color: Colors.black.withValues(alpha: 0.35)),
          ),
        ),

        // Tray panel
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SlideTransition(
            position: _slideAnim,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.72,
              ),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: topPadding),
                  _TrayHeader(onDismiss: _dismiss),
                  const Divider(height: 1, color: AppColors.divider),
                  Flexible(
                    child: BlocBuilder<NotificationsCubit, NotificationsState>(
                      builder: (context, state) {
                        if (state is NotificationsLoading ||
                            state is NotificationsInitial) {
                          return NotificationsShimmerView();
                        }
                        if (state is NotificationsError) {
                          return _ErrorView(
                            message: state.message,
                            onRetry: () =>
                                context.read<NotificationsCubit>().loadNotifications(),
                          );
                        }
                        if (state is NotificationsLoaded) {
                          return NotificationsBodyView(
                            notifications: state.notifications,
                            onBeforeNavigate: _dismiss,
                          );
                        }
                        return NotificationsShimmerView();
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TrayHeader extends StatelessWidget {
  final VoidCallback onDismiss;
  const _TrayHeader({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 8, 10),
      child: Row(
        children: [
          const Icon(Icons.notifications_rounded, size: 22, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text('Notifications', style: AppTextStyles.heading3),
          ),
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsLoaded &&
                  state.notifications.any((n) => !n.isRead)) {
                return TextButton(
                  onPressed: () =>
                      context.read<NotificationsCubit>().markAllAsRead(),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Mark all read',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 20),
            color: AppColors.textSecondary,
            onPressed: onDismiss,
            padding: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}

class NotificationsBodyView extends StatelessWidget {
  final List<NotificationModel> notifications;
  final VoidCallback? onBeforeNavigate;
  const NotificationsBodyView({
    super.key,
    required this.notifications,
    this.onBeforeNavigate,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: EmptyState(
          icon: Icons.notifications_none_rounded,
          title: 'No notifications yet',
          message: "You're all caught up!",
        ),
      );
    }

    final unread = notifications.where((n) => !n.isRead).toList();
    final read = notifications.where((n) => n.isRead).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      shrinkWrap: true,
      children: [
        if (unread.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text('New', style: AppTextStyles.label),
          ),
          ...unread.map((n) => _NotificationCard(
                notification: n,
                onBeforeNavigate: onBeforeNavigate,
              )),
        ],
        if (read.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text('Earlier', style: AppTextStyles.label),
          ),
          ...read.map((n) => _NotificationCard(
                notification: n,
                onBeforeNavigate: onBeforeNavigate,
              )),
        ],
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onBeforeNavigate;
  const _NotificationCard({required this.notification, this.onBeforeNavigate});

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;
    return GestureDetector(
      onTap: () {
        if (isUnread) {
          context.read<NotificationsCubit>().markAsRead(notification.id);
        }
        onBeforeNavigate?.call();
        context.push(
          '/home/notifications/${notification.id}',
          extra: notification,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUnread ? AppColors.surfaceVariant : AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isUnread
                ? AppColors.primary.withValues(alpha: 0.2)
                : AppColors.divider,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isUnread
                    ? AppColors.primary.withValues(alpha: 0.12)
                    : AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_rounded,
                size: 16,
                color: isUnread ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isUnread
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontWeight: isUnread
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (isUnread)
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    notification.body,
                    style: AppTextStyles.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.createdAt.toReadableWithTime(),
                    style: AppTextStyles.caption
                        .copyWith(fontSize: 10, color: AppColors.textHint),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline_rounded,
              size: 40, color: AppColors.error),
          const SizedBox(height: 12),
          Text(message,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center),
          const SizedBox(height: 16),
          TextButton(
            onPressed: onRetry,
            child: Text('Retry',
                style: AppTextStyles.label
                    .copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}

class NotificationsShimmerView extends StatelessWidget {
  const NotificationsShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            4,
            (_) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              height: 68,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
