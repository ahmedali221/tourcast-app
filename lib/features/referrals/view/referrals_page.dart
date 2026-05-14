import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/referrals/model/referral_model.dart';
import 'package:tourguide_app/features/referrals/viewmodel/referrals_cubit.dart';

class ReferralsPage extends StatelessWidget {
  const ReferralsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ReferralsCubit>()..loadReferrals(),
      child: const _ReferralsView(),
    );
  }
}

class _ReferralsView extends StatelessWidget {
  const _ReferralsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Referrals')),
      body: BlocConsumer<ReferralsCubit, ReferralsState>(
        listener: (context, state) {
          if (state is ReferralsError) {
            context.showSnackBar(state.message, isError: true);
          }
          if (state is ReferralLinkGenerated) {
            _showShareSheet(context, state.referralCode, state.referralLink);
          }
        },
        builder: (context, state) {
          if (state is ReferralsLoading || state is ReferralsInitial) {
            return _ShimmerView();
          }
          if (state is ReferralsError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<ReferralsCubit>().loadReferrals(),
            );
          }
          final referrals = switch (state) {
            ReferralsLoaded s => s.referrals,
            ReferralsGenerating s => s.referrals,
            ReferralLinkGenerated s => s.referrals,
            ReferralActivityLoading s => s.referrals,
            ReferralActivityLoaded s => s.referrals,
            _ => null,
          };
          if (referrals != null) {
            return _BodyView(
              referrals: referrals,
              isGenerating: state is ReferralsGenerating,
            );
          }
          return _ShimmerView();
        },
      ),
    );
  }

  void _showShareSheet(BuildContext context, String code, String link) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _ShareSheet(code: code, link: link),
    );
  }
}

class _BodyView extends StatelessWidget {
  final ReferralModel referrals;
  final bool isGenerating;
  const _BodyView({required this.referrals, required this.isGenerating});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Stats ────────────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Total Referrals',
                  value: referrals.totalReferred.toString(),
                  icon: Icons.people_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Total Earned',
                  value: referrals.totalEarned.toCurrency(),
                  icon: Icons.account_balance_wallet_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Generate button ──────────────────────────────────────────
          AppButton(
            label: 'Generate New Referral Code',
            isLoading: isGenerating,
            onPressed: isGenerating
                ? null
                : () => context.read<ReferralsCubit>().generateReferralLink(),
          ),
          const SizedBox(height: 24),

          // ── Referral entries list ────────────────────────────────────
          Text('Referral Codes', style: AppTextStyles.label),
          const SizedBox(height: 12),
          if (referrals.entries.isEmpty)
            const EmptyState(
              icon: Icons.people_outline,
              title: 'No referrals yet',
              message: 'Generate a code and share it to start earning!',
            )
          else
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: List.generate(referrals.entries.length, (i) {
                  final entry = referrals.entries[i];
                  return _ReferralEntryRow(
                    entry: entry,
                    isLast: i == referrals.entries.length - 1,
                    onTap: entry.status == 'REGISTERED' || entry.referredUser != null
                        ? () => _showActivitySheet(context, entry)
                        : null,
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }

  void _showActivitySheet(BuildContext context, ReferralEntryModel entry) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ReferralsCubit>()..loadReferralActivity(entry.id),
        child: _ActivitySheet(entry: entry),
      ),
    );
  }
}

class _ReferralEntryRow extends StatelessWidget {
  final ReferralEntryModel entry;
  final bool isLast;
  final VoidCallback? onTap;
  const _ReferralEntryRow({required this.entry, required this.isLast, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isCompleted = entry.status == 'COMPLETED';
    final isRegistered = entry.status == 'REGISTERED';
    final (statusColor, statusBg) = isCompleted
        ? (AppColors.success, AppColors.successBg)
        : isRegistered
            ? (AppColors.primary, AppColors.primary.withValues(alpha: 0.08))
            : (AppColors.textSecondary, AppColors.surfaceVariant);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(bottom: BorderSide(color: AppColors.divider)),
        ),
        child: Row(
          children: [
            // Code + copy
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        entry.referralCode,
                        style: AppTextStyles.bodyMedium.copyWith(
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: entry.referralCode));
                          context.showSnackBar('Code copied!');
                        },
                        child: const Icon(Icons.copy_rounded, size: 15, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.referredUser != null
                        ? 'Used by ${entry.referredUser}'
                        : 'Not used yet',
                    style: AppTextStyles.caption.copyWith(
                      color: entry.referredUser != null
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                  if (entry.referredAt != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Registered ${entry.referredAt!.toReadable()}',
                      style: AppTextStyles.caption.copyWith(color: AppColors.textHint, fontSize: 11),
                    ),
                  ],
                  const SizedBox(height: 2),
                  Text(
                    entry.createdAt.toReadable(),
                    style: AppTextStyles.caption.copyWith(color: AppColors.textHint, fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    entry.status,
                    style: AppTextStyles.caption.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
                if (entry.rewardAmount > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    '+${entry.rewardAmount.toCurrency()}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                if (onTap != null) ...[
                  const SizedBox(height: 4),
                  const Icon(Icons.chevron_right, size: 16, color: AppColors.textSecondary),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Share sheet (shown after generating a new link) ─────────────────────────

class _ShareSheet extends StatelessWidget {
  final String code;
  final String link;
  const _ShareSheet({required this.code, required this.link});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 20),
          Text('Referral Link Generated', style: AppTextStyles.heading3),
          const SizedBox(height: 4),
          Text('Share your code or link to start earning.', style: AppTextStyles.caption),
          const SizedBox(height: 20),
          // Code row
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Referral Code', style: AppTextStyles.caption),
                      const SizedBox(height: 4),
                      Text(
                        code,
                        style: AppTextStyles.bodyMedium.copyWith(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy_rounded, size: 20, color: AppColors.primary),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                    context.showSnackBar('Code copied!');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Link row
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Referral Link', style: AppTextStyles.caption),
                      const SizedBox(height: 4),
                      Text(
                        link,
                        style: AppTextStyles.caption.copyWith(color: AppColors.primary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy_rounded, size: 20, color: AppColors.primary),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: link));
                    context.showSnackBar('Link copied!');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppButton(
            label: 'Done',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// ─── Activity sheet ───────────────────────────────────────────────────────────

class _ActivitySheet extends StatelessWidget {
  final ReferralEntryModel entry;
  const _ActivitySheet({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
      child: BlocBuilder<ReferralsCubit, ReferralsState>(
        builder: (context, state) {
          final isLoading = state is ReferralActivityLoading;
          final activity = state is ReferralActivityLoaded && state.referralId == entry.id
              ? state.activity
              : null;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Referred User Activity', style: AppTextStyles.heading3),
                    const SizedBox(height: 4),
                    Text(
                      entry.referredUser ?? entry.referralCode,
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (activity == null)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: EmptyState(
                    icon: Icons.bar_chart_outlined,
                    title: 'No activity data',
                    message: 'Activity will appear once the user is active.',
                  ),
                )
              else
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (activity.windowMetadata.isNotEmpty) ...[
                          _SectionHeader('Referral Window'),
                          const SizedBox(height: 8),
                          _MetadataCard(data: activity.windowMetadata),
                          const SizedBox(height: 20),
                        ],
                        if (activity.subscriptions.isNotEmpty) ...[
                          _SectionHeader('Subscriptions (${activity.subscriptions.length})'),
                          const SizedBox(height: 8),
                          _ActivityList(items: activity.subscriptions),
                          const SizedBox(height: 20),
                        ],
                        if (activity.appUsageEvents.isNotEmpty) ...[
                          _SectionHeader('App Usage Events (${activity.appUsageEvents.length})'),
                          const SizedBox(height: 8),
                          _ActivityList(items: activity.appUsageEvents),
                          const SizedBox(height: 20),
                        ],
                        if (activity.promoRedemptions.isNotEmpty) ...[
                          _SectionHeader('Promo Redemptions (${activity.promoRedemptions.length})'),
                          const SizedBox(height: 8),
                          _ActivityList(items: activity.promoRedemptions),
                        ],
                        if (activity.subscriptions.isEmpty &&
                            activity.appUsageEvents.isEmpty &&
                            activity.promoRedemptions.isEmpty)
                          const EmptyState(
                            icon: Icons.bar_chart_outlined,
                            title: 'No activity yet',
                            message: 'Activity will appear once the user is active.',
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) =>
      Text(title, style: AppTextStyles.label);
}

class _MetadataCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const _MetadataCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: data.entries.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  e.key.replaceAll('_', ' '),
                  style: AppTextStyles.caption,
                ),
                Text(
                  '${e.value}',
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ActivityList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const _ActivityList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          final title = item['name'] ?? item['type'] ?? item['event'] ?? 'Item ${i + 1}';
          final subtitle = item['created_at'] ?? item['date'] ?? '';
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: i < items.length - 1
                  ? const Border(bottom: BorderSide(color: AppColors.divider))
                  : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$title', style: AppTextStyles.bodyMedium),
                      if (subtitle.isNotEmpty)
                        Text('$subtitle', style: AppTextStyles.caption),
                    ],
                  ),
                ),
                if (item['amount'] != null)
                  Text(
                    (item['amount'] as num).toDouble().toCurrency(),
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(height: 10),
          Text(value, style: AppTextStyles.heading3.copyWith(color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.caption),
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 48,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              4,
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
