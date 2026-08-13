import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/localization/language_switcher.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/commissions/model/commission_model.dart';
import 'package:tourguide_app/features/commissions/viewmodel/commissions_cubit.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';

class CommissionsPage extends StatelessWidget {
  const CommissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<CommissionsCubit>()..loadCommissions(),
      child: const _CommissionsView(),
    );
  }
}

class _CommissionsView extends StatelessWidget {
  const _CommissionsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: LanguageAppBar(title: Text(l10n.commissionsTitle)),
      body: BlocBuilder<CommissionsCubit, CommissionsState>(
        builder: (context, state) {
          if (state is CommissionsLoading || state is CommissionsInitial) {
            return _ShimmerView();
          }
          if (state is CommissionsError) {
            return ErrorView(
              message: state.message ?? l10n.commonSomethingWentWrong,
              onRetry: () => context.read<CommissionsCubit>().loadCommissions(),
            );
          }
          if (state is CommissionsLoaded) {
            return _BodyView(commissions: state.commissions);
          }
          return _ShimmerView();
        },
      ),
    );
  }
}

class _BodyView extends StatelessWidget {
  final List<CommissionModel> commissions;
  const _BodyView({required this.commissions});

  double get _totalEarned => commissions.fold(0.0, (sum, c) => sum + c.amount);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
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
                  bottom: -40,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.06),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.commissionsTotalEarned,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _totalEarned.toCurrency(),
                      style: AppTextStyles.heading1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.commissionsTransactionsCount(commissions.length),
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(l10n.commissionsHistorySection, style: AppTextStyles.label),
          const SizedBox(height: 12),
          if (commissions.isEmpty)
            EmptyState(
              icon: Icons.percent_rounded,
              title: l10n.commissionsEmptyTitle,
              message: l10n.commissionsEmptyMessage,
            )
          else
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: List.generate(commissions.length, (i) {
                  final c = commissions[i];
                  final (statusColor, statusBg) = switch (c.status
                      .toLowerCase()) {
                    'approved' ||
                    'paid' => (AppColors.success, AppColors.successBg),
                    'rejected' ||
                    'failed' => (AppColors.error, AppColors.errorBg),
                    _ => (
                      AppColors.badgePending,
                      AppColors.badgePending.withValues(alpha: 0.12),
                    ),
                  };
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: i < commissions.length - 1
                          ? const Border(
                              bottom: BorderSide(color: AppColors.divider),
                            )
                          : null,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: AppColors.successBg,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.trending_up_rounded,
                            size: 18,
                            color: AppColors.success,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                c.promoCode != null
                                    ? l10n.commissionsPromoCodeLabel(
                                        c.promoCode!,
                                      )
                                    : l10n.commissionsDirectSale,
                                style: AppTextStyles.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${c.commissionPercent.toStringAsFixed(0)}% of ${c.baseAmount.toCurrency()}',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                c.createdAt.toReadable(),
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 11,
                                  color: AppColors.textHint,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '+${c.amount.toCurrency()}',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: statusBg,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                c.status.toUpperCase(),
                                style: AppTextStyles.caption.copyWith(
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class _ShimmerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              5,
              (_) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
