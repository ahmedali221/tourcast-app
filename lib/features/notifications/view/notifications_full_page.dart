import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/localization/language_switcher.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/features/notifications/view/notifications_page.dart';
import 'package:tourguide_app/features/notifications/viewmodel/notifications_cubit.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';

class NotificationsFullPage extends StatelessWidget {
  const NotificationsFullPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (_) => locator<NotificationsCubit>()..loadNotifications(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: LanguageAppBar(
          title: Text(
            l10n.notificationsTrayTitle,
            style: AppTextStyles.heading3,
          ),
          backgroundColor: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1, color: AppColors.divider),
          ),
          actions: [
            BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state is NotificationsLoaded &&
                    state.notifications.any((n) => !n.isRead)) {
                  return TextButton(
                    onPressed: () =>
                        context.read<NotificationsCubit>().markAllAsRead(),
                    child: Text(
                      l10n.notificationsMarkAllRead,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoading ||
                state is NotificationsInitial) {
              return const NotificationsShimmerView();
            }
            if (state is NotificationsError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      size: 40,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.message ?? l10n.commonSomethingWentWrong,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context
                          .read<NotificationsCubit>()
                          .loadNotifications(),
                      child: Text(
                        l10n.commonRetry,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is NotificationsLoaded) {
              return NotificationsBodyView(notifications: state.notifications);
            }
            return const NotificationsShimmerView();
          },
        ),
      ),
    );
  }
}
