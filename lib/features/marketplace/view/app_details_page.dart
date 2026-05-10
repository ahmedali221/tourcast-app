import 'package:flutter/material.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/utils/extensions.dart';

class AppDetailsPage extends StatefulWidget {
  final String appId;
  const AppDetailsPage({super.key, required this.appId});

  @override
  State<AppDetailsPage> createState() => _AppDetailsPageState();
}

class _AppDetailsPageState extends State<AppDetailsPage> {
  // int _selectedPlan = 1;
  // final _promoCtrl = TextEditingController();

  // static const _plans = [
  //   (id: 0, name: 'Monthly', cycle: 'Monthly', price: 99.0, features: ['Unlimited itineraries', 'Cloud sync', 'Email support']),
  //   (id: 1, name: 'Yearly', cycle: 'Save 20%', price: 79.0, features: ['Everything in Monthly', 'Priority support', 'Custom branding']),
  // ];

  @override
  void dispose() {
    // _promoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(title: const Text('App Details'), backgroundColor: AppColors.surface),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
        child: Column(
          children: [
            // Hero icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.primaryLight],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'T',
                style: AppTextStyles.heading1.copyWith(color: Colors.white, fontSize: 44),
              ),
            ),
            const SizedBox(height: 12),
            Text('Tour Planner', style: AppTextStyles.heading2),
            const SizedBox(height: 8),
            Text(
              'Build custom itineraries, manage bookings, and share day-by-day plans with your clients.',
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle_outline, color: AppColors.success, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Free — No subscription required',
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.success),
                  ),
                ],
              ),
            ),

            // // Plans
            // const SizedBox(height: 28),
            // Text('Choose a Plan', style: AppTextStyles.label),
            // const SizedBox(height: 12),
            // ...

            // // Promo Code
            // Text('Promo Code', style: AppTextStyles.label),
            // ...
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
          label: 'Get App — Free',
          onPressed: () => context.showSnackBar('Coming soon'),
        ),
      ),
    );
  }
}
