import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/shared/widgets/nt_logo.dart';
import 'package:tourguide_app/core/storage/app_storage.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _resolveNextRoute();
  }

  Future<void> _resolveNextRoute() async {
    final tokenFuture = AppStorage.getToken();
    final results = await Future.wait([
      tokenFuture,
      Future.delayed(const Duration(milliseconds: 900)),
    ]);
    if (!mounted) return;
    final token = results[0] as String?;
    context.go(token != null ? AppRoutes.home : AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            const NtLogo(size: 96),
            Text(
              'Your Guide. Your Business.',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
