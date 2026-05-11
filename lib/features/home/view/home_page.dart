import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/auth/viewmodel/auth_cubit.dart';
import 'package:tourguide_app/features/notifications/model/notification_model.dart';
import 'package:tourguide_app/features/notifications/viewmodel/notifications_cubit.dart';
import 'package:tourguide_app/features/profile/viewmodel/profile_cubit.dart';
import 'package:tourguide_app/features/wallet/viewmodel/wallet_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<AuthCubit>()),
        BlocProvider(create: (_) => locator<ProfileCubit>()..loadProfile()),
        BlocProvider(create: (_) => locator<WalletCubit>()..loadWallet()),
        BlocProvider(create: (_) => locator<NotificationsCubit>()..loadNotifications()),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) context.go(AppRoutes.login);
        },
        child: const _HomeScaffold(),
      ),
    );
  }
}

class _HomeScaffold extends StatelessWidget {
  const _HomeScaffold();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ValueNotifier<int>(0);

    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, index, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: const _DashboardBody(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (i) {
              switch (i) {
                case 0:
                  selectedIndex.value = 0;
                case 1:
                  context.push(AppRoutes.marketplace);
                case 2:
                  context.push(AppRoutes.wallet);
                case 3:
                  context.push(AppRoutes.support);
                case 4:
                  context.push(AppRoutes.profile);
                case 5:
                  _confirmLogout(context);
              }
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.surface,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondary,
            selectedLabelStyle: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
            unselectedLabelStyle: AppTextStyles.caption.copyWith(fontSize: 10),
            elevation: 8,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.storefront_outlined),
                activeIcon: Icon(Icons.storefront),
                label: 'Marketplace',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                activeIcon: Icon(Icons.account_balance_wallet),
                label: 'Wallet',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.headset_mic_outlined),
                activeIcon: Icon(Icons.headset_mic),
                label: 'Support',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: 'Logout',
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthCubit>().logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _TopBar()),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(24, 12, 24, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                _VerificationBanner(),
                SizedBox(height: 20),
                _WalletCard(),
                SizedBox(height: 20),
                _QuickActions(),
                SizedBox(height: 20),
                _Announcements(),
                SizedBox(height: 20),
                _ProfileCompleteness(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

String _greeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) return 'Good morning';
  if (hour < 18) return 'Good afternoon';
  return 'Good evening';
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  final firstName = state.profile.fullName.split(' ').first;
                  return Text(
                    '${_greeting()}, $firstName 👋',
                    style: AppTextStyles.heading3,
                  );
                }
                return _ShimmerBox(width: 200, height: 22);
              },
            ),
          ),
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              final unread = state is NotificationsLoaded
                  ? state.notifications.where((n) => !n.isRead).length
                  : 0;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, size: 24),
                    color: AppColors.textPrimary,
                    onPressed: () => context.push(AppRoutes.notifications),
                  ),
                  if (unread > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.surface, width: 1.5),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _VerificationBanner extends StatelessWidget {
  const _VerificationBanner();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is! ProfileLoaded) return const SizedBox.shrink();
        if (state.profile.verificationStatus == 'VERIFIED') return const SizedBox.shrink();

        final isRejected = state.profile.verificationStatus == 'REJECTED';
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: isRejected
                ? AppColors.error.withValues(alpha: 0.08)
                : AppColors.warningBg,
            border: Border.all(
              color: isRejected
                  ? AppColors.error.withValues(alpha: 0.3)
                  : AppColors.primary.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                isRejected ? Icons.cancel_outlined : Icons.warning_amber_outlined,
                size: 18,
                color: isRejected ? AppColors.error : AppColors.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  isRejected
                      ? 'Verification was rejected. Please resubmit your documents.'
                      : 'Complete identity verification to unlock all features',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
                ),
              ),
              GestureDetector(
                onTap: () => context.push(AppRoutes.verification),
                child: Text(
                  isRejected ? 'Resubmit' : 'Verify Now',
                  style: AppTextStyles.label.copyWith(
                    color: isRejected ? AppColors.error : AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WalletCard extends StatelessWidget {
  const _WalletCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -40,
            top: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Balance',
                style: AppTextStyles.caption.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 4),
              BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  if (state is WalletLoaded) {
                    return Text(
                      state.wallet.balance.toCurrency(),
                      style: AppTextStyles.heading1.copyWith(color: Colors.white),
                    );
                  }
                  return Shimmer.fromColors(
                    baseColor: Colors.white24,
                    highlightColor: Colors.white54,
                    child: Container(
                      width: 160,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => context.push(AppRoutes.wallet),
                child: Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withValues(alpha: 0.8), width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Request Payout',
                    style: AppTextStyles.label.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  static const _actions = [
    (label: 'Commissions', icon: Icons.bar_chart_rounded, route: AppRoutes.commissions),
    (label: 'Referrals', icon: Icons.share_outlined, route: AppRoutes.referrals),
    // (label: 'Subscriptions', icon: Icons.layers_outlined, route: AppRoutes.marketplace), // OUT OF SCOPE — Phase 2
    // (label: 'Knowledge Center', icon: Icons.menu_book_outlined, route: AppRoutes.knowledgeCenter), // OUT OF SCOPE — Phase 2
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.8,
      children: _actions
          .map(
            (a) => GestureDetector(
              onTap: () => context.push(a.route),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(a.icon, size: 26, color: AppColors.primary),
                    const SizedBox(height: 8),
                    Text(
                      a.label,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Announcements extends StatelessWidget {
  const _Announcements();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Announcements',
          style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoading || state is NotificationsInitial) {
              return SizedBox(
                height: 96,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (_, _) => _ShimmerBox(width: 240, height: 96),
                ),
              );
            }

            final notifications = state is NotificationsLoaded
                ? state.notifications
                : <NotificationModel>[];

            if (notifications.isEmpty) {
              return Container(
                height: 80,
                alignment: Alignment.center,
                child: Text(
                  'No announcements yet.',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
              );
            }

            return SizedBox(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: notifications.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (_, i) {
                  final item = notifications[i];
                  return Container(
                    width: 240,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border(
                        left: BorderSide(color: AppColors.primary, width: 3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: AppTextStyles.bodyMedium),
                        const SizedBox(height: 6),
                        Text(
                          item.body,
                          style: AppTextStyles.caption,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ProfileCompleteness extends StatelessWidget {
  const _ProfileCompleteness();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading || state is ProfileInitial) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ShimmerBox(width: 180, height: 16),
                  _ShimmerBox(width: 100, height: 16),
                ],
              ),
              const SizedBox(height: 8),
              _ShimmerBox(width: double.infinity, height: 6),
            ],
          );
        }

        final percent = state is ProfileLoaded ? state.profile.completenessPercent : 0;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Profile $percent% Complete', style: AppTextStyles.label),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.editProfile),
                  child: Text(
                    'Complete Profile',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: percent / 100,
                minHeight: 6,
                backgroundColor: AppColors.divider,
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;

  const _ShimmerBox({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
