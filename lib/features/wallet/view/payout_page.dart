import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/core/utils/validators.dart';
import 'package:tourguide_app/features/wallet/model/payout_profile_model.dart';
import 'package:tourguide_app/features/wallet/viewmodel/wallet_cubit.dart';

enum _PayoutStep { methodPicker, profileForm, amountForm }

class PayoutPage extends StatefulWidget {
  final double balance;
  final List<PayoutMethodModel> methods;
  final PayoutProfileModel? savedProfile;
  final bool skipToAmount;

  const PayoutPage({
    super.key,
    required this.balance,
    required this.methods,
    this.savedProfile,
    this.skipToAmount = false,
  });

  @override
  State<PayoutPage> createState() => _PayoutPageState();
}

class _PayoutPageState extends State<PayoutPage> {
  late _PayoutStep _step;
  PayoutMethodModel? _selectedMethod;

  @override
  void initState() {
    super.initState();
    if (widget.skipToAmount || widget.savedProfile != null) {
      _step = _PayoutStep.amountForm;
    } else {
      _step = _PayoutStep.methodPicker;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is PayoutSuccess) {
          context.pop();
        }
        if (state is PayoutProfileSaved) {
          context.showSnackBar('Payout profile saved!');
          setState(() {
            _step = _PayoutStep.amountForm;
            // keep _selectedMethod set so back nav knows we came via profile form
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
            _PayoutStep.methodPicker => _MethodPickerBody(
                key: const ValueKey('picker'),
                methods: widget.methods,
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
                balance: widget.balance,
                savedProfile: widget.savedProfile,
                onChangeProfile: () => setState(() => _step = _PayoutStep.methodPicker),
              ),
          },
        ),
      ),
    );
  }

  String get _appBarTitle => switch (_step) {
        _PayoutStep.methodPicker => 'Payout Method',
        _PayoutStep.profileForm => _selectedMethod?.name ?? 'Payment Details',
        _PayoutStep.amountForm => 'Request Payout',
      };

  void _onBack() {
    switch (_step) {
      case _PayoutStep.methodPicker:
        context.pop();
      case _PayoutStep.profileForm:
        setState(() => _step = _PayoutStep.methodPicker);
      case _PayoutStep.amountForm:
        // If we arrived here directly (profile already saved), just go back.
        // If we arrived via profile form, go back to method picker.
        if (_cameFromProfileForm) {
          setState(() => _step = _PayoutStep.methodPicker);
        } else {
          context.pop();
        }
    }
  }

  bool get _cameFromProfileForm => _selectedMethod != null;
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
                          for (final e in widget.savedProfile!.details.entries) ...[
                            Text(
                              '${e.key.replaceAll('_', ' ')}: ${e.value}',
                              style: AppTextStyles.caption.copyWith(color: AppColors.success),
                            ),
                          ],
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

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500));
  }
}
