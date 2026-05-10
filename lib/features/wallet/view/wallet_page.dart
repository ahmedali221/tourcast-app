import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/core/utils/validators.dart';
import 'package:tourguide_app/features/wallet/model/wallet_model.dart';
import 'package:tourguide_app/features/wallet/viewmodel/wallet_cubit.dart';
import 'package:shimmer/shimmer.dart';

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
          if (state is PayoutSuccess) context.showSnackBar('Payout request submitted');
          if (state is WalletError) context.showSnackBar(state.message, isError: true);
        },
        builder: (context, state) {
          if (state is WalletLoading || state is WalletInitial) return _ShimmerView();
          if (state is WalletError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<WalletCubit>().loadWallet(),
            );
          }
          if (state is WalletLoaded) return _BodyView(wallet: state.wallet);
          return _ShimmerView();
        },
      ),
    );
  }
}

class _BodyView extends StatelessWidget {
  final WalletModel wallet;
  const _BodyView({required this.wallet});

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
                    Text('Available Balance', style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                    const SizedBox(height: 4),
                    Text(
                      wallet.balance.toCurrency(),
                      style: AppTextStyles.heading1.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _showPayoutSheet(context, wallet.balance),
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
                          style: AppTextStyles.label.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
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
                              Text(
                                tx.description,
                                style: AppTextStyles.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
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
        ],
      ),
    );
  }

  void _showPayoutSheet(BuildContext context, double balance) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<WalletCubit>(),
        child: _PayoutSheet(balance: balance),
      ),
    );
  }
}

class _PayoutSheet extends StatefulWidget {
  final double balance;
  const _PayoutSheet({required this.balance});

  @override
  State<_PayoutSheet> createState() => _PayoutSheetState();
}

class _PayoutSheetState extends State<_PayoutSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  String _method = 'Bank Transfer';

  static const _methods = ['Bank Transfer', 'Vodafone Cash', 'InstaPay'];

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Text('Request Payout', style: AppTextStyles.heading3),
              const SizedBox(height: 24),
              Text('Amount (EGP)', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: '0.00'),
                validator: Validators.amount,
              ),
              const SizedBox(height: 16),
              Text('Payment Method', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _method,
                items: _methods
                    .map((m) => DropdownMenuItem(value: m, child: Text(m, style: AppTextStyles.body)))
                    .toList(),
                onChanged: (v) => setState(() => _method = v!),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Funds typically arrive within 2–3 business days. Available balance: ${widget.balance.toCurrency()}',
                  style: AppTextStyles.caption,
                ),
              ),
              const SizedBox(height: 24),
              BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) => AppButton(
                  label: 'Submit Request',
                  isLoading: state is WalletLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<WalletCubit>().requestPayout(
                            double.parse(_amountCtrl.text),
                            _method,
                          );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
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
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
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
