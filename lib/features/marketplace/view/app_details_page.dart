import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/marketplace/model/app_model.dart';
import 'package:tourguide_app/features/marketplace/viewmodel/marketplace_cubit.dart';

class AppDetailsPage extends StatelessWidget {
  final String appId;
  final AppModel? app;

  const AppDetailsPage({super.key, required this.appId, this.app});

  @override
  Widget build(BuildContext context) {
    if (app != null) return _AppDetailsView(app: app!);

    return BlocProvider(
      create: (_) => locator<MarketplaceCubit>()..loadAppDetails(int.parse(appId)),
      child: BlocBuilder<MarketplaceCubit, MarketplaceState>(
        builder: (context, state) {
          if (state is MarketplaceLoading || state is MarketplaceInitial) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is MarketplaceDetailLoaded) {
            return _AppDetailsView(app: state.app);
          }
          if (state is MarketplaceError) {
            return Scaffold(
              appBar: AppBar(),
              body: ErrorView(
                message: state.message,
                onRetry: () => context.read<MarketplaceCubit>().loadAppDetails(int.parse(appId)),
              ),
            );
          }
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

class _AppDetailsView extends StatelessWidget {
  final AppModel app;
  const _AppDetailsView({required this.app});

  static const _cardColors = [
    Color(0xFF1A6B4A),
    Color(0xFF3B82F6),
    Color(0xFFD4A017),
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
    Color(0xFF0EA5E9),
  ];

  @override
  Widget build(BuildContext context) {
    final bg = _cardColors[app.id % _cardColors.length];
    final isFree = app.plans.isEmpty || app.plans.every((p) => p.price == 0);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(title: Text(app.name), backgroundColor: AppColors.surface),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: bg.withValues(alpha: 0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                app.name.isNotEmpty ? app.name[0].toUpperCase() : '?',
                style: AppTextStyles.heading1.copyWith(color: Colors.white, fontSize: 44),
              ),
            ),
            const SizedBox(height: 12),
            Text(app.name, style: AppTextStyles.heading2),
            if (app.category != null) ...[
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(app.category!, style: AppTextStyles.caption),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              app.description,
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isFree
                    ? AppColors.success.withValues(alpha: 0.1)
                    : AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isFree
                      ? AppColors.success.withValues(alpha: 0.3)
                      : AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isFree ? Icons.check_circle_outline : Icons.workspace_premium_outlined,
                    color: isFree ? AppColors.success : AppColors.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isFree ? 'Free — No subscription required' : _planSummary(app.plans),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isFree ? AppColors.success : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            if (app.plans.isNotEmpty && !isFree) ...[
              const SizedBox(height: 28),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Available Plans', style: AppTextStyles.label),
              ),
              const SizedBox(height: 12),
              ...app.plans.map((plan) => _PlanCard(plan: plan)),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: AppButton(
          label: isFree ? 'Get App — Free' : 'Subscribe',
          onPressed: () => context.showSnackBar('Coming soon'),
        ),
      ),
    );
  }

  String _planSummary(List<PlanModel> plans) {
    if (plans.isEmpty) return 'Paid';
    final lowest = plans.map((p) => p.price).reduce((a, b) => a < b ? a : b);
    return 'From \$${lowest.toStringAsFixed(0)} / mo';
  }
}

class _PlanCard extends StatelessWidget {
  final PlanModel plan;
  const _PlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
                Text(plan.name, style: AppTextStyles.bodyMedium),
                if (plan.planType.isNotEmpty)
                  Text(plan.planType, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text(
            plan.price == 0 ? 'Free' : '\$${plan.price.toStringAsFixed(0)}',
            style: AppTextStyles.bodyMedium.copyWith(
              color: plan.price == 0 ? AppColors.success : AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
