import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/features/notifications/view/notifications_page.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/announcements/model/announcement_model.dart';
import 'package:tourguide_app/features/announcements/viewmodel/announcements_cubit.dart';
import 'package:tourguide_app/features/home/viewmodel/home_promo_codes_cubit.dart';
import 'package:tourguide_app/features/marketplace/model/app_model.dart';
import 'package:tourguide_app/features/notifications/viewmodel/notifications_cubit.dart';
import 'package:tourguide_app/features/profile/viewmodel/profile_cubit.dart';
import 'package:tourguide_app/features/verification/viewmodel/verification_cubit.dart';
import 'package:tourguide_app/features/wallet/viewmodel/wallet_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<ProfileCubit>()..loadProfile()),
        BlocProvider(create: (_) => locator<VerificationCubit>()..loadStatus()),
        BlocProvider(create: (_) => locator<WalletCubit>()..loadWallet()),
        BlocProvider(create: (_) => locator<NotificationsCubit>()..loadNotifications()),
        BlocProvider(create: (_) => locator<AnnouncementsCubit>()..loadAnnouncements()),
        BlocProvider(create: (_) => locator<HomePromoCodesCubit>()..load()),
      ],
      child: const _HomeScaffold(),
    );
  }
}

class _HomeScaffold extends StatelessWidget {
  const _HomeScaffold();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: _DashboardBody(),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationCubit, VerificationState>(
      builder: (context, state) {
        if (state is VerificationLoaded) {
          if (state.verification == null) return const _StatusBanner(isNotSubmitted: true);
          final status = state.verification!.status.toUpperCase();
          if (status == 'PENDING') return const _StatusBanner(isPending: true);
          if (status == 'REJECTED') {
            return _StatusBanner(
              rejectionReason: state.verification!.rejectionReason,
            );
          }
        }
        return _FullDashboard();
      },
    );
  }
}

class _FullDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _TopBar()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                const _AccountStatusBanner(),
                const _WalletCard(),
                const SizedBox(height: 20),
                const _QuickActions(),
                const SizedBox(height: 20),
                const _PromoCodesSection(),
                const SizedBox(height: 20),
                const _Announcements(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

enum _BannerType { notSubmitted, pending, rejected }

class _StatusBanner extends StatelessWidget {
  final bool isNotSubmitted;
  final bool isPending;
  final String? rejectionReason;

  const _StatusBanner({
    this.isNotSubmitted = false,
    this.isPending = false,
    this.rejectionReason,
  });

  _BannerType get _type {
    if (isNotSubmitted) return _BannerType.notSubmitted;
    if (isPending) return _BannerType.pending;
    return _BannerType.rejected;
  }

  @override
  Widget build(BuildContext context) {
    final type = _type;

    final color = switch (type) {
      _BannerType.notSubmitted => AppColors.primary,
      _BannerType.pending => const Color(0xFFD4A017),
      _BannerType.rejected => AppColors.error,
    };
    final bg = switch (type) {
      _BannerType.notSubmitted => AppColors.surfaceVariant,
      _BannerType.pending => const Color(0xFFFFF8E6),
      _BannerType.rejected => const Color(0xFFFFF0F0),
    };
    final icon = switch (type) {
      _BannerType.notSubmitted => Icons.upload_file_outlined,
      _BannerType.pending => Icons.hourglass_top_rounded,
      _BannerType.rejected => Icons.cancel_outlined,
    };
    final title = switch (type) {
      _BannerType.notSubmitted => 'Verification Required',
      _BannerType.pending => 'Account Under Review',
      _BannerType.rejected => 'Application Rejected',
    };
    final message = switch (type) {
      _BannerType.notSubmitted =>
        'You need to submit your verification documents before you can access the app.',
      _BannerType.pending =>
        'Your guide application is being reviewed by our team. You\'ll be notified once approved.',
      _BannerType.rejected =>
        'Your application was not approved. Please review the notes below and contact support.',
    };
    final ctaLabel = switch (type) {
      _BannerType.notSubmitted => 'Submit Verification',
      _BannerType.pending => 'Contact Support',
      _BannerType.rejected => 'Contact Support',
    };
    final ctaRoute = switch (type) {
      _BannerType.notSubmitted => AppRoutes.verification,
      _BannerType.pending => AppRoutes.support,
      _BannerType.rejected => AppRoutes.support,
    };

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TopBar(),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withValues(alpha: 0.35), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: color, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.heading3.copyWith(color: color),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: color.withValues(alpha: 0.85),
                      height: 1.5,
                    ),
                  ),
                  if (type == _BannerType.rejected && rejectionReason?.isNotEmpty == true) ...[
                    const SizedBox(height: 12),
                    Text('Review Notes', style: AppTextStyles.label.copyWith(color: color)),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: color.withValues(alpha: 0.25)),
                      ),
                      child: Text(
                        rejectionReason!,
                        style: AppTextStyles.caption.copyWith(
                          color: color.withValues(alpha: 0.9),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => context.push(ctaRoute),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        ctaLabel,
                        style: AppTextStyles.label.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
                    onPressed: () => showNotificationsTray(context),
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
              BlocBuilder<VerificationCubit, VerificationState>(
                builder: (context, verState) {
                  final canPayout = verState is VerificationLoaded &&
                      verState.verification != null &&
                      verState.verification!.status.toUpperCase() == 'VERIFIED';
                  return GestureDetector(
                    onTap: canPayout
                        ? () => context.go(AppRoutes.wallet)
                        : () => context.showSnackBar(
                              'Payouts are available once your account is verified.',
                              isError: true,
                            ),
                    child: Opacity(
                      opacity: canPayout ? 1.0 : 0.5,
                      child: Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.8),
                              width: 1.5),
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
                  );
                },
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
        BlocBuilder<AnnouncementsCubit, AnnouncementsState>(
          builder: (context, state) {
            if (state is AnnouncementsLoading || state is AnnouncementsInitial) {
              return SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (_, _) => _ShimmerBox(width: 220, height: 200),
                ),
              );
            }

            final announcements = state is AnnouncementsLoaded ? state.announcements : <AnnouncementModel>[];

            return SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: announcements.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (_, i) {
                  final item = announcements[i];
                  return GestureDetector(
                    onTap: () => context.push(
                      '/home/announcement/${item.id}',
                      extra: item,
                    ),
                    child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.divider),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.imageUrl != null)
                            Image.network(
                              item.imageUrl!,
                              width: double.infinity,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, e, stack) => Container(
                                height: 100,
                                color: AppColors.surfaceVariant,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.textHint,
                                  size: 28,
                                ),
                              ),
                            )
                          else
                            Container(
                              height: 100,
                              color: AppColors.surfaceVariant,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.campaign_outlined,
                                color: AppColors.primary,
                                size: 32,
                              ),
                            ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: AppTextStyles.bodyMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.content,
                                    style: AppTextStyles.caption,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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

class _PromoCodesSection extends StatelessWidget {
  const _PromoCodesSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePromoCodesCubit, HomePromoCodesState>(
      builder: (context, state) {
        if (state is HomePromoCodesLoading || state is HomePromoCodesInitial) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Promo Codes', style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w500)),
              const SizedBox(height: 12),
              SizedBox(
                height: 96,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (_, _) => _ShimmerBox(width: 200, height: 96),
                ),
              ),
            ],
          );
        }

        if (state is! HomePromoCodesLoaded || state.entries.isEmpty) {
          return const SizedBox.shrink();
        }

        final entries = state.entries;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Promo Codes', style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Builder(builder: (ctx) {
              final flat = [
                for (final e in entries)
                  for (final code in e.codes) (app: e.app, code: code),
              ];
              return SizedBox(
                height: 96,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: flat.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (ctx, i) => _PromoCodeCard(app: flat[i].app, code: flat[i].code),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class _PromoCodeCard extends StatelessWidget {
  final AppModel app;
  final PromoCodeModel code;

  const _PromoCodeCard({required this.app, required this.code});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/marketplace/app/${app.id}'),
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              app.name,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    code.code,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: code.code));
                    context.showSnackBar('Copied!');
                  },
                  child: const Icon(Icons.copy_rounded, size: 18, color: AppColors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountStatusBanner extends StatelessWidget {
  const _AccountStatusBanner();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationCubit, VerificationState>(
      builder: (context, state) {
        if (state is! VerificationLoaded) return const SizedBox.shrink();

        final verification = state.verification;
        final rawStatus = verification?.status.toUpperCase();

        // VERIFIED → no banner needed inside the full dashboard.
        if (rawStatus == 'VERIFIED') return const SizedBox.shrink();

        final Color color;
        final Color bg;
        final IconData icon;
        final String title;
        final String message;
        final String ctaLabel;
        final String ctaRoute;

        if (rawStatus == 'PENDING') {
          color = const Color(0xFFD4A017);
          bg = const Color(0xFFFFF8E6);
          icon = Icons.hourglass_top_rounded;
          title = 'Account Under Review';
          message =
              'Your verification is being reviewed. You can browse the app but cannot create promo codes, referrals, or request payouts until approved.';
          ctaLabel = 'Contact Support';
          ctaRoute = AppRoutes.support;
        } else {
          // null (not submitted) — unlikely here since the dashboard only shows
          // for VERIFIED, but guard gracefully.
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withValues(alpha: 0.35), width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: AppTextStyles.caption.copyWith(
                    color: color.withValues(alpha: 0.85),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => context.push(ctaRoute),
                  child: Text(
                    ctaLabel,
                    style: AppTextStyles.caption.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationColor: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
