import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/core/utils/validators.dart';
import 'package:tourguide_app/features/wallet/model/payout_profile_model.dart';
import 'package:tourguide_app/features/wallet/viewmodel/wallet_cubit.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<WalletCubit>()..loadPaymentMethods(),
      child: const _PaymentMethodsView(),
    );
  }
}

class _PaymentMethodsView extends StatefulWidget {
  const _PaymentMethodsView();

  @override
  State<_PaymentMethodsView> createState() => _PaymentMethodsViewState();
}

class _PaymentMethodsViewState extends State<_PaymentMethodsView> {
  PayoutMethodModel? _selectedMethod;
  bool _showForm = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is PaymentMethodsLoaded) {
          if (_showForm) {
            context.showSnackBar('Payment account saved!');
            setState(() {
              _showForm = false;
              _selectedMethod = null;
            });
          }
        }
        if (state is WalletError) {
          context.showSnackBar(state.message, isError: true);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Text(_showForm
              ? (_selectedMethod?.name ?? 'Payment Details')
              : 'Payment Methods'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            onPressed: () {
              if (_showForm) {
                setState(() {
                  _showForm = false;
                  _selectedMethod = null;
                });
              } else {
                context.pop();
              }
            },
          ),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _showForm && _selectedMethod != null
              ? _MethodFormBody(
                  key: ValueKey(_selectedMethod!.id),
                  method: _selectedMethod!,
                  onSaved: (details) {
                    context
                        .read<WalletCubit>()
                        .updatePaymentMethod(_selectedMethod!.id, details);
                  },
                )
              : _MethodListBody(
                  key: const ValueKey('list'),
                  onSetup: (method, existingDetails) {
                    setState(() {
                      _selectedMethod = method;
                      _showForm = true;
                    });
                  },
                ),
        ),
      ),
    );
  }
}

// ─── Method list ──────────────────────────────────────────────────────────────

class _MethodListBody extends StatelessWidget {
  final void Function(PayoutMethodModel method, Map<String, dynamic>? existing)
      onSetup;

  const _MethodListBody({super.key, required this.onSetup});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state is WalletLoading || state is WalletInitial) {
          return _ShimmerView();
        }
        if (state is WalletError) {
          return ErrorView(
            message: state.message,
            onRetry: () => context.read<WalletCubit>().loadPaymentMethods(),
          );
        }
        if (state is! PaymentMethodsLoaded) return _ShimmerView();

        final methods = state.methods;
        final saved = state.savedProfile;

        if (methods.isEmpty) {
          return const EmptyState(
            icon: Icons.payments_outlined,
            title: 'No payment methods available',
            message: 'Please contact support.',
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Active account banner
              if (saved != null) ...[
                _ActiveAccountCard(
                  profile: saved,
                  onEdit: () {
                    final activeMethod = methods.firstWhere(
                      (m) => m.id == saved.payoutMethodId,
                      orElse: () => methods.first,
                    );
                    onSetup(activeMethod, saved.details);
                  },
                ),
                const SizedBox(height: 28),
              ],

              Text(
                saved == null ? 'Choose a payment method' : 'All Methods',
                style: AppTextStyles.label,
              ),
              const SizedBox(height: 12),

              ...methods.map((method) {
                final isActive = saved?.payoutMethodId == method.id;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _MethodCard(
                    method: method,
                    isActive: isActive,
                    onTap: () => onSetup(
                      method,
                      isActive ? saved?.details : null,
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

// ─── Active account card ──────────────────────────────────────────────────────

class _ActiveAccountCard extends StatelessWidget {
  final PayoutProfileModel profile;
  final VoidCallback onEdit;

  const _ActiveAccountCard({required this.profile, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -40,
            bottom: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'ACTIVE',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onEdit,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Edit',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                profile.methodName,
                style: AppTextStyles.heading2.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              ...profile.details.entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: [
                      Text(
                        '${e.key.replaceAll('_', ' ').capitalize}: ',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${e.value}',
                          style: AppTextStyles.caption.copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Individual method card ───────────────────────────────────────────────────

class _MethodCard extends StatelessWidget {
  final PayoutMethodModel method;
  final bool isActive;
  final VoidCallback onTap;

  const _MethodCard({
    required this.method,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.04)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isActive ? AppColors.primary.withValues(alpha: 0.4) : AppColors.divider,
            width: isActive ? 1.5 : 1,
          ),
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
              child: const Icon(
                Icons.account_balance_wallet_outlined,
                size: 22,
                color: AppColors.primary,
              ),
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
            if (isActive)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Active',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              )
            else
              Text(
                'Set up',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Method form (setup / edit) ───────────────────────────────────────────────

class _MethodFormBody extends StatefulWidget {
  final PayoutMethodModel method;
  final void Function(Map<String, dynamic> details) onSaved;

  const _MethodFormBody({
    super.key,
    required this.method,
    required this.onSaved,
  });

  @override
  State<_MethodFormBody> createState() => _MethodFormBodyState();
}

class _MethodFormBodyState extends State<_MethodFormBody> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = {};
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controllers.isEmpty) {
      final cubitState = context.read<WalletCubit>().state;
      final savedDetails = cubitState is PaymentMethodsLoaded &&
              cubitState.savedProfile?.payoutMethodId == widget.method.id
          ? cubitState.savedProfile?.details
          : null;

      for (final f in widget.method.fieldSchema) {
        _controllers[f.key] = TextEditingController(
          text: savedDetails?[f.key]?.toString() ?? '',
        );
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubitState = context.watch<WalletCubit>().state;
    final isEditing = cubitState is PaymentMethodsLoaded &&
        cubitState.savedProfile?.payoutMethodId == widget.method.id;

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
                border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      size: 16, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isEditing
                          ? 'Update your saved payment details for ${widget.method.name}.'
                          : 'This will become your active payout account.',
                      style: AppTextStyles.caption
                          .copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ...widget.method.fieldSchema.expand((field) => [
              Text(
                field.label,
                style: AppTextStyles.caption
                    .copyWith(fontWeight: FontWeight.w500),
              ),
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
            ]),
            const SizedBox(height: 8),
            BlocBuilder<WalletCubit, WalletState>(
              builder: (context, state) => AppButton(
                label: isEditing ? 'Save Changes' : 'Set as Active Account',
                isLoading: state is WalletLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final details = {
                      for (final e in _controllers.entries)
                        e.key: e.value.text.trim(),
                    };
                    widget.onSaved(details);
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

// ─── Shimmer ──────────────────────────────────────────────────────────────────

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
              3,
              (_) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
