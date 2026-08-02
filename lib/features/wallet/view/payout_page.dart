import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/core/utils/validators.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/features/verification/viewmodel/verification_cubit.dart';
import 'package:tourguide_app/features/wallet/model/payout_model.dart';
import 'package:tourguide_app/features/wallet/model/payout_profile_model.dart';
import 'package:tourguide_app/features/wallet/viewmodel/wallet_cubit.dart';

enum _PayoutStep { history, methodPicker, profileForm, amountForm }

class PayoutPage extends StatelessWidget {
  const PayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<WalletCubit>()..loadWallet(),
      child: const _PayoutView(),
    );
  }
}

class _PayoutView extends StatefulWidget {
  const _PayoutView();

  @override
  State<_PayoutView> createState() => _PayoutViewState();
}

class _PayoutViewState extends State<_PayoutView> {
  _PayoutStep _step = _PayoutStep.history;
  PayoutMethodModel? _selectedMethod;
  double _balance = 0;
  List<PayoutMethodModel> _methods = [];
  PayoutProfileModel? _savedProfile;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is WalletLoaded) {
          setState(() => _balance = state.wallet.balance);
        }
        if (state is PayoutSheetReady) {
          setState(() {
            _balance = state.wallet.balance;
            _methods = state.methods;
            _savedProfile = state.savedProfile;
            _step = state.savedProfile != null
                ? _PayoutStep.amountForm
                : _PayoutStep.methodPicker;
          });
        }
        if (state is PayoutProfileSaved) {
          context.showSnackBar('Payout profile saved!');
          setState(() {
            _methods = state.methods;
            _step = _PayoutStep.amountForm;
          });
        }
        if (state is PayoutSuccess) {
          context.showSnackBar('Payout request submitted');
          context.read<WalletCubit>().loadWallet();
          setState(() {
            _step = _PayoutStep.history;
            _selectedMethod = null;
          });
        }
        if (state is WalletError) {
          context.showSnackBar(state.message, isError: true);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Text(_appBarTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            onPressed: _onBack,
          ),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: switch (_step) {
            _PayoutStep.history => _HistoryBody(
                key: const ValueKey('history'),
                onRequestPayout: () =>
                    context.read<WalletCubit>().openPayoutSheet(),
              ),
            _PayoutStep.methodPicker => _MethodPickerBody(
                key: const ValueKey('picker'),
                methods: _methods,
                onPick: (m) => setState(() {
                  _selectedMethod = m;
                  _step = _PayoutStep.profileForm;
                }),
              ),
            _PayoutStep.profileForm => _ProfileFormBody(
                key: ValueKey(_selectedMethod?.id),
                method: _selectedMethod!,
              ),
            _PayoutStep.amountForm => _AmountFormBody(
                key: const ValueKey('amount'),
                balance: _balance,
                savedProfile: _savedProfile,
                onChangeProfile: () =>
                    setState(() => _step = _PayoutStep.methodPicker),
              ),
          },
        ),
      ),
    );
  }

  String get _appBarTitle => switch (_step) {
        _PayoutStep.history => 'Payout Requests',
        _PayoutStep.methodPicker => 'Payout Method',
        _PayoutStep.profileForm => _selectedMethod?.name ?? 'Payment Details',
        _PayoutStep.amountForm => 'Request Payout',
      };

  void _onBack() {
    switch (_step) {
      case _PayoutStep.history:
        context.pop();
      case _PayoutStep.methodPicker:
        setState(() => _step = _PayoutStep.history);
      case _PayoutStep.profileForm:
        setState(() => _step = _PayoutStep.methodPicker);
      case _PayoutStep.amountForm:
        if (_selectedMethod != null) {
          setState(() => _step = _PayoutStep.methodPicker);
        } else {
          setState(() => _step = _PayoutStep.history);
        }
    }
  }
}

// ─── Step 0: History ──────────────────────────────────────────────────────────

class _HistoryBody extends StatelessWidget {
  final VoidCallback onRequestPayout;
  const _HistoryBody({super.key, required this.onRequestPayout});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state is WalletLoading || state is WalletInitial) {
          return _ShimmerView();
        }
        final payouts = switch (state) {
          WalletLoaded s => s.payouts,
          PayoutProfileSaved s => s.payouts,
          _ => <PayoutModel>[],
        };
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<VerificationCubit, VerificationState>(
                builder: (context, verState) {
                  final canPayout = verState is VerificationLoaded &&
                      verState.verification != null &&
                      verState.verification!.status.toUpperCase() == 'VERIFIED';
                  return AppButton(
                    label: 'Request Payout',
                    onPressed: canPayout
                        ? onRequestPayout
                        : () => context.showSnackBar(
                              'Payouts are available once your account is verified.',
                              isError: true,
                            ),
                  );
                },
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => context.push(AppRoutes.paymentMethods),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.account_balance_wallet_outlined,
                          size: 18, color: AppColors.primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text('Manage Payment Account',
                            style: AppTextStyles.bodyMedium),
                      ),
                      const Icon(Icons.chevron_right,
                          size: 18, color: AppColors.textSecondary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text('History', style: AppTextStyles.label),
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
                      final (statusColor, statusBg) =
                          switch (p.status.toLowerCase()) {
                        'completed' || 'paid' =>
                          (AppColors.success, AppColors.successBg),
                        'rejected' || 'failed' =>
                          (AppColors.error, AppColors.errorBg),
                        _ => (
                            AppColors.primary,
                            AppColors.primary.withValues(alpha: 0.08)
                          ),
                      };
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: i < payouts.length - 1
                              ? const Border(
                                  bottom:
                                      BorderSide(color: AppColors.divider))
                              : null,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color:
                                    AppColors.primary.withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.upload_rounded,
                                  size: 18, color: AppColors.primary),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p.paymentMethod,
                                      style: AppTextStyles.bodyMedium),
                                  const SizedBox(height: 2),
                                  Text(p.createdAt.toReadable(),
                                      style: AppTextStyles.caption),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  p.amount.toCurrency(),
                                  style: AppTextStyles.bodyMedium
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
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
      },
    );
  }
}

// ─── Step 1: Method picker ────────────────────────────────────────────────────

class _MethodPickerBody extends StatelessWidget {
  final List<PayoutMethodModel> methods;
  final void Function(PayoutMethodModel) onPick;

  const _MethodPickerBody({super.key, required this.methods, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose how you want to receive your money.',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          if (methods.isEmpty)
            const EmptyState(
              icon: Icons.payments_outlined,
              title: 'No payout methods available',
              message: 'Please contact support.',
            )
          else
            for (final m in methods) ...[
              _MethodTile(method: m, onTap: () => onPick(m)),
              const SizedBox(height: 12),
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
          color: AppColors.surface,
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
              child: const Icon(Icons.account_balance_wallet_outlined,
                  size: 22, color: AppColors.primary),
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

// ─── Step 2: Profile form ─────────────────────────────────────────────────────

class _ProfileFormBody extends StatefulWidget {
  final PayoutMethodModel method;
  const _ProfileFormBody({super.key, required this.method});

  @override
  State<_ProfileFormBody> createState() => _ProfileFormBodyState();
}

class _ProfileFormBodyState extends State<_ProfileFormBody> {
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
    for (final c in _controllers.values) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 24),
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
                      for (final e in _controllers.entries)
                        e.key: e.value.text.trim(),
                    };
                    context
                        .read<WalletCubit>()
                        .savePayoutProfile(widget.method.id, details);
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
        _ => TextInputType.text,
      };
}

// ─── Step 3: Amount form ──────────────────────────────────────────────────────

class _AmountFormBody extends StatefulWidget {
  final double balance;
  final PayoutProfileModel? savedProfile;
  final VoidCallback onChangeProfile;

  const _AmountFormBody({
    super.key,
    required this.balance,
    this.savedProfile,
    required this.onChangeProfile,
  });

  @override
  State<_AmountFormBody> createState() => _AmountFormBodyState();
}

class _AmountFormBodyState extends State<_AmountFormBody> {
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
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available: ${widget.balance.toCurrency()}',
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            if (widget.savedProfile != null) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.successBg,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline,
                        size: 18, color: AppColors.success),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.savedProfile!.methodName,
                              style: AppTextStyles.bodyMedium
                                  .copyWith(color: AppColors.success)),
                          ...widget.savedProfile!.details.entries.map(
                            (e) => Text(
                              '${e.key.replaceAll('_', ' ')}: ${e.value}',
                              style: AppTextStyles.caption
                                  .copyWith(color: AppColors.success),
                            ),
                          ),
                        ],
                      ),
                    ),
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
            _FieldLabel('Amount (USD)'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _amountCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                hintText: '0.00',
                helperText: 'Minimum payout amount is \$10',
              ),
              validator: (v) => Validators.amount(v, min: 10),
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

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500));
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
              height: 52,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              4,
              (_) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 72,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
