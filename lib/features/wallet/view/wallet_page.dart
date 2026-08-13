import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/localization/language_switcher.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/verification/viewmodel/verification_cubit.dart';
import 'package:tourguide_app/features/wallet/model/wallet_model.dart';
import 'package:tourguide_app/features/wallet/viewmodel/wallet_cubit.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<WalletCubit>()..loadWallet(),
      child: const _WalletView(),
    );
  }
}

class _WalletView extends StatelessWidget {
  const _WalletView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: LanguageAppBar(title: Text(l10n.walletTitle)),
      body: BlocConsumer<WalletCubit, WalletState>(
        listener: (context, state) {
          if (state is WalletError) {
            context.showSnackBar(
              state.message ?? l10n.commonSomethingWentWrong,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state is WalletLoading || state is WalletInitial)
            return _ShimmerView();
          if (state is WalletError) {
            return ErrorView(
              message: state.message ?? l10n.commonSomethingWentWrong,
              onRetry: () => context.read<WalletCubit>().loadWallet(),
            );
          }
          final wallet = switch (state) {
            WalletLoaded s => s.wallet,
            _ => null,
          };
          if (wallet != null) return _BodyView(wallet: wallet);
          return _ShimmerView();
        },
      ),
    );
  }
}

// ─── Body ─────────────────────────────────────────────────────────────────────

class _BodyView extends StatelessWidget {
  final WalletModel wallet;
  const _BodyView({required this.wallet});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance card
          Container(
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
                  right: -50,
                  bottom: -50,
                  child: Container(
                    width: 180,
                    height: 180,
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
                      l10n.profileAvailableBalance,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      wallet.balance.toCurrency(),
                      style: AppTextStyles.heading1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<VerificationCubit, VerificationState>(
                      builder: (context, verState) {
                        final canPayout =
                            verState is VerificationLoaded &&
                            verState.verification != null &&
                            verState.verification!.status.toUpperCase() ==
                                'VERIFIED';
                        return GestureDetector(
                          onTap: canPayout
                              ? () => context.push(AppRoutes.payout)
                              : () => context.showSnackBar(
                                  l10n.commonPayoutsUnavailable,
                                  isError: true,
                                ),
                          child: Opacity(
                            opacity: canPayout ? 1.0 : 0.5,
                            child: Container(
                              height: 36,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                l10n.homeRequestPayout,
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
          ),
          const SizedBox(height: 24),
          // Transaction history
          Text(l10n.walletTransactionHistory, style: AppTextStyles.label),
          const SizedBox(height: 12),
          if (wallet.transactions.isEmpty)
            EmptyState(
              icon: Icons.receipt_long_outlined,
              title: l10n.walletNoTransactions,
              message: l10n.walletNoTransactionsMessage,
            )
          else
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: List.generate(wallet.transactions.length, (i) {
                  final tx = wallet.transactions[i];
                  final isCredit = tx.type.toUpperCase() == 'CREDIT';
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: i < wallet.transactions.length - 1
                          ? const Border(
                              bottom: BorderSide(color: AppColors.divider),
                            )
                          : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isCredit
                                ? AppColors.successBg
                                : AppColors.errorBg,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isCredit
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            size: 18,
                            color: isCredit
                                ? AppColors.success
                                : AppColors.error,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tx.type,
                                style: AppTextStyles.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                tx.createdAt.toReadable(),
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${isCredit ? '+' : ''}${tx.amount.toCurrency()}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isCredit
                                ? AppColors.success
                                : AppColors.error,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          const SizedBox(height: 24),
          // Payout requests navigation card
          GestureDetector(
            onTap: () => context.push(AppRoutes.payout),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.payments_outlined,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.walletPayoutRequestsTitle,
                          style: AppTextStyles.bodyMedium,
                        ),
                        Text(
                          l10n.walletPayoutRequestsSubtitle,
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
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
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              4,
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
