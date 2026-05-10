import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/empty_state.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/agreements/model/agreement_model.dart';
import 'package:tourguide_app/features/agreements/viewmodel/agreements_cubit.dart';

class AgreementsPage extends StatelessWidget {
  const AgreementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<AgreementsCubit>()..loadPendingAgreements(),
      child: const _AgreementsView(),
    );
  }
}

class _AgreementsView extends StatelessWidget {
  const _AgreementsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Legal Agreements')),
      body: BlocConsumer<AgreementsCubit, AgreementsState>(
        listener: (context, state) {
          if (state is AgreementAccepted) {
            context.showSnackBar('Agreement accepted');
            context.read<AgreementsCubit>().loadPendingAgreements();
          }
          if (state is AgreementsError) {
            context.showSnackBar(state.message, isError: true);
          }
        },
        builder: (context, state) {
          if (state is AgreementsLoading || state is AgreementsInitial) {
            return _ShimmerView();
          }
          if (state is AgreementsError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<AgreementsCubit>().loadPendingAgreements(),
            );
          }
          if (state is AgreementsLoaded) {
            return _BodyView(agreements: state.agreements);
          }
          return _ShimmerView();
        },
      ),
    );
  }
}

class _BodyView extends StatelessWidget {
  final List<AgreementModel> agreements;
  const _BodyView({required this.agreements});

  @override
  Widget build(BuildContext context) {
    if (agreements.isEmpty) {
      return const EmptyState(
        icon: Icons.check_circle_outline,
        title: 'All agreements accepted!',
        message: 'You have no pending agreements.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      itemCount: agreements.length,
      itemBuilder: (_, i) => _AgreementCard(agreement: agreements[i]),
    );
  }
}

class _AgreementCard extends StatefulWidget {
  final AgreementModel agreement;
  const _AgreementCard({required this.agreement});

  @override
  State<_AgreementCard> createState() => _AgreementCardState();
}

class _AgreementCardState extends State<_AgreementCard> {
  bool _expanded = false;
  bool _agreedChecked = false;

  @override
  Widget build(BuildContext context) {
    final isAccepted = widget.agreement.isAccepted;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isAccepted ? AppColors.success.withValues(alpha: 0.3) : AppColors.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isAccepted ? AppColors.successBg : AppColors.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isAccepted ? Icons.check_circle_rounded : Icons.description_outlined,
                    size: 20,
                    color: isAccepted ? AppColors.success : AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.agreement.title, style: AppTextStyles.bodyMedium),
                      const SizedBox(height: 2),
                      if (isAccepted)
                        Text(
                          'Accepted',
                          style: AppTextStyles.caption.copyWith(color: AppColors.success, fontWeight: FontWeight.w500),
                        )
                      else
                        Text(
                          'Pending your acceptance',
                          style: AppTextStyles.caption.copyWith(color: const Color(0xFFD4A017)),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: Icon(
                    _expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1, color: AppColors.divider),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: Text(widget.agreement.content, style: AppTextStyles.body),
                    ),
                  ),
                  if (!isAccepted) ...[
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => setState(() => _agreedChecked = !_agreedChecked),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _agreedChecked ? AppColors.primary : Colors.transparent,
                              border: Border.all(
                                color: _agreedChecked ? AppColors.primary : AppColors.border,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: _agreedChecked
                                ? const Icon(Icons.check, size: 12, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'I have read and agree to the terms above',
                              style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AgreementsCubit, AgreementsState>(
                      builder: (context, state) => AppButton(
                        label: 'Accept Agreement',
                        isLoading: state is AgreementsLoading,
                        onPressed: _agreedChecked
                            ? () => context.read<AgreementsCubit>().acceptAgreement(widget.agreement.id)
                            : null,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
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
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Column(
          children: List.generate(
            3,
            (_) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 80,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ),
    );
  }
}
