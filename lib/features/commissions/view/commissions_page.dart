import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/commissions/model/commission_model.dart';
import 'package:tourguide_app/features/commissions/viewmodel/commissions_cubit.dart';

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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Commissions')),
      body: BlocBuilder<CommissionsCubit, CommissionsState>(
        builder: (context, state) {
          if (state is CommissionsLoading || state is CommissionsInitial) {
            return _ShimmerView();
          }
          if (state is CommissionsError) {
            return ErrorView(
              message: state.message,
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

  double get _totalEarned =>
      commissions.fold(0.0, (sum, c) => sum + c.amount);

  @override
  Widget build(BuildContext context) {
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
                      'Total Commissions Earned',
                      style: AppTextStyles.caption.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _totalEarned.toCurrency(),
                      style: AppTextStyles.heading1.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${commissions.length} transactions',
                      style: AppTextStyles.caption.copyWith(color: Colors.white60),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Commission History', style: AppTextStyles.label),
          const SizedBox(height: 12),
          if (commissions.isEmpty)
            const EmptyState(
              icon: Icons.percent_rounded,
              title: 'No commissions yet',
              message: 'Your earned commissions will appear here.',
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
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: i < commissions.length - 1
                          ? const Border(bottom: BorderSide(color: AppColors.divider))
                          : null,
                    ),
                    child: Row(
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
                              // OUT OF SCOPE — Phase 2 (Promo Code Redemption)
                              // Container(
                              //   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              //   decoration: BoxDecoration(
                              //     color: AppColors.surfaceVariant,
                              //     borderRadius: BorderRadius.circular(4),
                              //   ),
                              //   child: Text(
                              //     c.promoCode,
                              //     style: AppTextStyles.caption.copyWith(
                              //       fontFamily: 'monospace',
                              //       fontWeight: FontWeight.w600,
                              //       color: AppColors.primary,
                              //       letterSpacing: 0.5,
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(height: 4),
                              Text(
                                c.redeemedBy,
                                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(c.earnedAt.toReadable(), style: AppTextStyles.caption.copyWith(fontSize: 11)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '+${c.amount.toCurrency()}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w700,
                          ),
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
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              5,
              (_) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 72,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
