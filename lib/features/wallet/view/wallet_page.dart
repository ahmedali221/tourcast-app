import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/wallet/model/payout_model.dart';
import 'package:tourguide_app/features/wallet/model/wallet_model.dart';
import 'package:tourguide_app/features/wallet/viewmodel/wallet_cubit.dart';

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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Wallet')),
      body: BlocConsumer<WalletCubit, WalletState>(
        listener: (context, state) {
          if (state is PayoutSuccess) {
            context.showSnackBar('Payout request submitted');
          }
          if (state is WalletError) {
            context.showSnackBar(state.message, isError: true);
          }
          if (state is PayoutSheetReady) {
            final cubit = context.read<WalletCubit>();
            context.push(
              AppRoutes.payout,
              extra: {
                'cubit': cubit,
                'balance': state.wallet.balance,
                'methods': state.methods,
                'savedProfile': state.savedProfile,
              },
            );
          }
        },
        builder: (context, state) {
          if (state is WalletLoading || state is WalletInitial) return _ShimmerView();
          if (state is WalletError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<WalletCubit>().loadWallet(),
            );
          }
          final (wallet, payouts) = switch (state) {
            WalletLoaded s => (s.wallet, s.payouts),
            PayoutSheetReady s => (s.wallet, s.payouts),
            PayoutProfileSaved s => (s.wallet, s.payouts),
            _ => (null, null),
          };
          if (wallet != null) return _BodyView(wallet: wallet, payouts: payouts ?? []);
          return _ShimmerView();
        },
      ),
    );
  }

}

// ─── Body ─────────────────────────────────────────────────────────────────────

class _BodyView extends StatelessWidget {
  final WalletModel wallet;
  final List<PayoutModel> payouts;
  const _BodyView({required this.wallet, required this.payouts});

  @override
  Widget build(BuildContext context) {
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
                    Text('Available Balance',
                        style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                    const SizedBox(height: 4),
                    Text(
                      wallet.balance.toCurrency(),
                      style: AppTextStyles.heading1.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<WalletCubit, WalletState>(
                      builder: (context, state) {
                        final isLoading = state is WalletLoading;
                        return GestureDetector(
                          onTap: isLoading
                              ? null
                              : () => context.read<WalletCubit>().openPayoutSheet(),
                          child: Container(
                            height: 36,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withValues(alpha: isLoading ? 0.4 : 0.8),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: isLoading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Request Payout',
                                    style: AppTextStyles.label.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
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
          Text('Transaction History', style: AppTextStyles.label),
          const SizedBox(height: 12),
          if (wallet.transactions.isEmpty)
            const EmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'No transactions yet',
              message: 'Your transaction history will appear here.',
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
                  final isCredit = tx.type == 'credit';
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: i < wallet.transactions.length - 1
                          ? const Border(bottom: BorderSide(color: AppColors.divider))
                          : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isCredit ? AppColors.successBg : AppColors.errorBg,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isCredit ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                            size: 18,
                            color: isCredit ? AppColors.success : AppColors.error,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tx.description,
                                  style: AppTextStyles.bodyMedium,
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 2),
                              Text(tx.createdAt.toReadable(), style: AppTextStyles.caption),
                            ],
                          ),
                        ),
                        Text(
                          '${isCredit ? '+' : ''}${tx.amount.toCurrency()}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isCredit ? AppColors.success : AppColors.error,
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
          // Payout requests
          Text('Payout Requests', style: AppTextStyles.label),
          const SizedBox(height: 12),
          if (payouts.isEmpty)
            const EmptyState(
              icon: Icons.payments_outlined,
              title: 'No payout requests yet',
              message: 'Your payout requests will appear here.',
            )
          else
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: List.generate(payouts.length, (i) {
                  final p = payouts[i];
                  final (statusColor, statusBg) = switch (p.status.toLowerCase()) {
                    'completed' || 'paid' => (AppColors.success, AppColors.successBg),
                    'rejected' || 'failed' => (AppColors.error, AppColors.errorBg),
                    _ => (AppColors.primary, AppColors.primary.withValues(alpha: 0.08)),
                  };
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: i < payouts.length - 1
                          ? const Border(bottom: BorderSide(color: AppColors.divider))
                          : null,
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
                          child: const Icon(Icons.upload_rounded, size: 18, color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.paymentMethod, style: AppTextStyles.bodyMedium),
                              const SizedBox(height: 2),
                              Text(p.createdAt.toReadable(), style: AppTextStyles.caption),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              p.amount.toCurrency(),
                              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusBg,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                p.status.toUpperCase(),
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
              height: 140,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              4,
              (_) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 72,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
