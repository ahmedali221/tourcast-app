import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/shared/widgets/logout_button.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/core/utils/validators.dart';
import 'package:tourguide_app/features/wallet/model/payout_model.dart';
import 'package:tourguide_app/features/wallet/model/payout_profile_model.dart';
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
      appBar: AppBar(title: const Text('Wallet'), actions: [const LogoutButton()]),
      body: BlocConsumer<WalletCubit, WalletState>(
        listener: (context, state) {
          if (state is PayoutSuccess) {
            context.showSnackBar('Payout request submitted');
          }
          if (state is WalletError) {
            context.showSnackBar(state.message, isError: true);
          }
          if (state is PayoutSheetReady) {
            _openPayoutSheet(context, state);
          }
          if (state is PayoutProfileSaved) {
            context.showSnackBar('Payout profile saved!');
            _openPayoutSheetFromSaved(context, state);
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

  void _openPayoutSheet(BuildContext context, PayoutSheetReady state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<WalletCubit>(),
        child: _PayoutSheet(
          balance: state.wallet.balance,
          methods: state.methods,
          savedProfile: state.savedProfile,
        ),
      ),
    );
  }

  void _openPayoutSheetFromSaved(BuildContext context, PayoutProfileSaved state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<WalletCubit>(),
        child: _PayoutSheet(
          balance: state.wallet.balance,
          methods: state.methods,
          savedProfile: null, // just saved, go straight to amount step
          skipToAmount: true,
        ),
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

// ─── Payout sheet root ────────────────────────────────────────────────────────

enum _SheetStep { methodPicker, profileForm, amountForm }

class _PayoutSheet extends StatefulWidget {
  final double balance;
  final List<PayoutMethodModel> methods;
  final PayoutProfileModel? savedProfile;
  final bool skipToAmount;

  const _PayoutSheet({
    required this.balance,
    required this.methods,
    this.savedProfile,
    this.skipToAmount = false,
  });

  @override
  State<_PayoutSheet> createState() => _PayoutSheetState();
}

class _PayoutSheetState extends State<_PayoutSheet> {
  late _SheetStep _step;
  PayoutMethodModel? _selectedMethod;

  @override
  void initState() {
    super.initState();
    if (widget.skipToAmount) {
      _step = _SheetStep.amountForm;
    } else if (widget.savedProfile != null) {
      // Profile already exists — go straight to amount
      _step = _SheetStep.amountForm;
    } else {
      _step = _SheetStep.methodPicker;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is PayoutProfileSaved || state is PayoutSuccess) {
          Navigator.pop(context);
        }
        if (state is WalletError) {
          Navigator.pop(context);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: switch (_step) {
            _SheetStep.methodPicker => _MethodPicker(
                key: const ValueKey('picker'),
                balance: widget.balance,
                methods: widget.methods,
                onPick: (m) => setState(() {
                  _selectedMethod = m;
                  _step = _SheetStep.profileForm;
                }),
              ),
            _SheetStep.profileForm => _ProfileForm(
                key: ValueKey(_selectedMethod?.id),
                method: _selectedMethod!,
                onBack: () => setState(() => _step = _SheetStep.methodPicker),
              ),
            _SheetStep.amountForm => _AmountForm(
                key: const ValueKey('amount'),
                balance: widget.balance,
                savedProfile: widget.savedProfile,
                onChangeProfile: widget.savedProfile != null
                    ? () => setState(() => _step = _SheetStep.methodPicker)
                    : null,
              ),
          },
        ),
      ),
    );
  }
}

// ─── Step 1: Method picker ────────────────────────────────────────────────────

class _MethodPicker extends StatelessWidget {
  final double balance;
  final List<PayoutMethodModel> methods;
  final void Function(PayoutMethodModel) onPick;

  const _MethodPicker({
    super.key,
    required this.balance,
    required this.methods,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DragHandle(),
          const SizedBox(height: 20),
          Text('Set Up Payout Method', style: AppTextStyles.heading3),
          const SizedBox(height: 4),
          Text(
            'Choose a method and enter your financial details.',
            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          if (methods.isEmpty)
            const EmptyState(
              icon: Icons.payments_outlined,
              title: 'No payout methods available',
              message: 'Please contact support.',
            )
          else
            for (final m in methods) ...[
              _MethodTile(method: m, onTap: () => onPick(m)),
              const SizedBox(height: 10),
            ],
        ],
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  final PayoutMethodModel method;
  final VoidCallback onTap;
  const _MethodTile({required this.method, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.account_balance_wallet_outlined, size: 22, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(method.name, style: AppTextStyles.bodyMedium),
                  if (method.description != null)
                    Text(method.description!, style: AppTextStyles.caption),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

// ─── Step 2: Profile form (dynamic fields from field_schema) ──────────────────

class _ProfileForm extends StatefulWidget {
  final PayoutMethodModel method;
  final VoidCallback onBack;
  const _ProfileForm({super.key, required this.method, required this.onBack});

  @override
  State<_ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<_ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = {
      for (final f in widget.method.fieldSchema) f.key: TextEditingController(),
    };
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DragHandle(),
            const SizedBox(height: 16),
            Row(
              children: [
                GestureDetector(
                  onTap: widget.onBack,
                  child: const Icon(Icons.arrow_back_ios_new,
                      size: 18, color: AppColors.textPrimary),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.account_balance_wallet_outlined,
                      size: 18, color: AppColors.primary),
                ),
                const SizedBox(width: 10),
                Text(widget.method.name, style: AppTextStyles.heading3),
              ],
            ),
            const SizedBox(height: 20),
            // Info banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 16, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This info is saved to your payout profile and used for all future withdrawals.',
                      style: AppTextStyles.caption.copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Dynamic fields
            for (final field in widget.method.fieldSchema) ...[
              _FieldLabel(field.label),
              const SizedBox(height: 6),
              TextFormField(
                controller: _controllers[field.key],
                keyboardType: _keyboardType(field.type),
                decoration: InputDecoration(hintText: field.label),
                validator: field.required
                    ? (v) => Validators.required(v, fieldName: field.label)
                    : null,
              ),
              const SizedBox(height: 16),
            ],
            const SizedBox(height: 8),
            BlocBuilder<WalletCubit, WalletState>(
              builder: (context, state) => AppButton(
                label: 'Save & Continue',
                isLoading: state is WalletLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final details = {
                      for (final e in _controllers.entries) e.key: e.value.text.trim(),
                    };
                    context.read<WalletCubit>().savePayoutProfile(
                          widget.method.id,
                          details,
                        );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextInputType _keyboardType(String type) => switch (type) {
        'phone' => TextInputType.phone,
        'number' => const TextInputType.numberWithOptions(decimal: true),
        'iban' => TextInputType.text,
        _ => TextInputType.text,
      };
}

// ─── Step 3: Amount form ──────────────────────────────────────────────────────

class _AmountForm extends StatefulWidget {
  final double balance;
  final PayoutProfileModel? savedProfile;
  final VoidCallback? onChangeProfile;

  const _AmountForm({
    super.key,
    required this.balance,
    this.savedProfile,
    this.onChangeProfile,
  });

  @override
  State<_AmountForm> createState() => _AmountFormState();
}

class _AmountFormState extends State<_AmountForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DragHandle(),
            const SizedBox(height: 20),
            Text('Request Payout', style: AppTextStyles.heading3),
            const SizedBox(height: 4),
            Text(
              'Available: ${widget.balance.toCurrency()}',
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            // Saved profile summary
            if (widget.savedProfile != null) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.successBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline, size: 18, color: AppColors.success),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.savedProfile!.methodName,
                              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.success)),
                          for (final e in widget.savedProfile!.details.entries)
                            Text(
                              '${e.key.replaceAll('_', ' ')}: ${e.value}',
                              style: AppTextStyles.caption.copyWith(color: AppColors.success),
                            ),
                        ],
                      ),
                    ),
                    if (widget.onChangeProfile != null)
                      GestureDetector(
                        onTap: widget.onChangeProfile,
                        child: Text(
                          'Change',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
            _FieldLabel('Amount (EGP)'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _amountCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(hintText: '0.00'),
              validator: Validators.amount,
            ),
            const SizedBox(height: 24),
            BlocBuilder<WalletCubit, WalletState>(
              builder: (context, state) => AppButton(
                label: 'Submit Request',
                isLoading: state is WalletLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<WalletCubit>()
                        .requestPayout(double.parse(_amountCtrl.text));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shared helpers ───────────────────────────────────────────────────────────

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500));
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
