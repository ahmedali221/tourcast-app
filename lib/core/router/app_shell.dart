import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/features/auth/viewmodel/auth_cubit.dart';
import 'package:tourguide_app/features/verification/viewmodel/verification_cubit.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) context.go(AppRoutes.login);
          },
        ),
        BlocListener<VerificationCubit, VerificationState>(
          listener: (context, state) {
            if (state is VerificationLoaded &&
                state.verification != null &&
                state.verification!.status.toUpperCase() == 'REJECTED') {
              context.go(AppRoutes.verification);
            }
          },
        ),
      ],
      child: _ShellScaffold(navigationShell: navigationShell),
    );
  }
}

class _ShellScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const _ShellScaffold({required this.navigationShell});

  // Home (0), Support (3), Profile (4) are accessible when restricted.
  // Home shows the status/pending banner; Marketplace (1) and Wallet (2) redirect to verification.
  static const _allowedWhenRestricted = {0, 3, 4};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final verificationState = context.watch<VerificationCubit>().state;

    final isRestricted = verificationState is VerificationLoaded &&
        (verificationState.verification == null ||
            verificationState.verification!.status.toUpperCase() == 'PENDING' ||
            verificationState.verification!.status.toUpperCase() == 'REJECTED');

    final index = navigationShell.currentIndex;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          if (isRestricted && !_allowedWhenRestricted.contains(i)) {
            context.go(AppRoutes.verification);
            return;
          }
          navigationShell.goBranch(i, initialLocation: i == index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTextStyles.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
        unselectedLabelStyle: AppTextStyles.caption.copyWith(fontSize: 10),
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: _navIcon(Icons.home_outlined, 0, isRestricted),
            activeIcon: _navIcon(Icons.home, 0, isRestricted),
            label: l10n.navHome,
          ),
          BottomNavigationBarItem(
            icon: _navIcon(Icons.storefront_outlined, 1, isRestricted),
            activeIcon: _navIcon(Icons.storefront, 1, isRestricted),
            label: l10n.navMarketplace,
          ),
          BottomNavigationBarItem(
            icon: _navIcon(Icons.account_balance_wallet_outlined, 2, isRestricted),
            activeIcon: _navIcon(Icons.account_balance_wallet, 2, isRestricted),
            label: l10n.navWallet,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.headset_mic_outlined),
            activeIcon: const Icon(Icons.headset_mic),
            label: l10n.navSupport,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }

  Widget _navIcon(IconData icon, int tabIndex, bool isRestricted) {
    if (!isRestricted || _allowedWhenRestricted.contains(tabIndex)) {
      return Icon(icon);
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: AppColors.textHint),
        Positioned(
          right: -4,
          top: -4,
          child: Icon(Icons.lock, size: 10, color: AppColors.textHint),
        ),
      ],
    );
  }
}
