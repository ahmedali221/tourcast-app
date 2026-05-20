import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/router/app_shell.dart';
import 'package:tourguide_app/core/storage/app_storage.dart';

import 'package:tourguide_app/features/auth/view/login_page.dart';
import 'package:tourguide_app/features/auth/view/register_page.dart';
import 'package:tourguide_app/features/auth/view/forgot_password_page.dart';
import 'package:tourguide_app/features/auth/view/verify_email_page.dart';
import 'package:tourguide_app/features/profile/view/profile_page.dart';
import 'package:tourguide_app/features/profile/view/edit_profile_page.dart';
import 'package:tourguide_app/features/verification/view/verification_page.dart';
import 'package:tourguide_app/features/verification/view/verification_success_page.dart';
import 'package:tourguide_app/features/marketplace/view/app_details_page.dart';
import 'package:tourguide_app/features/marketplace/view/marketplace_page.dart';
import 'package:tourguide_app/features/wallet/view/wallet_page.dart';
import 'package:tourguide_app/features/wallet/model/payout_profile_model.dart';
import 'package:tourguide_app/features/wallet/view/payout_page.dart';
import 'package:tourguide_app/features/wallet/viewmodel/wallet_cubit.dart';
import 'package:tourguide_app/features/commissions/view/commissions_page.dart';
import 'package:tourguide_app/features/referrals/view/referrals_page.dart';
import 'package:tourguide_app/features/support/view/support_page.dart';
import 'package:tourguide_app/features/support/view/new_ticket_page.dart';
import 'package:tourguide_app/features/support/view/ticket_detail_page.dart';
import 'package:tourguide_app/features/agreements/view/agreements_page.dart';
import 'package:tourguide_app/features/home/view/home_page.dart';
import 'package:tourguide_app/features/announcements/view/announcement_detail_page.dart';
import 'package:tourguide_app/features/announcements/model/announcement_model.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/notifications/local_notification_service.dart';
import 'package:tourguide_app/features/auth/viewmodel/auth_cubit.dart';
import 'package:tourguide_app/features/notifications/view/notifications_full_page.dart';
import 'package:tourguide_app/features/verification/viewmodel/verification_cubit.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  redirect: _redirect,
  routes: [
    // ---------- Auth ----------
    GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginPage()),
    GoRoute(path: AppRoutes.register, builder: (_, _) => const RegisterPage()),
    GoRoute(path: AppRoutes.forgotPassword, builder: (_, _) => const ForgotPasswordPage()),
    GoRoute(path: AppRoutes.verifyEmail, builder: (_, _) => const VerifyEmailPage()),

    // ---------- Verification (full-screen, outside shell) ----------
    GoRoute(path: AppRoutes.verification, builder: (_, _) => const VerificationPage()),
    GoRoute(path: AppRoutes.verificationSuccess, builder: (_, _) => const VerificationSuccessPage()),

    // ---------- Agreements (full-screen, outside shell) ----------
    GoRoute(path: AppRoutes.agreements, builder: (_, _) => const AgreementsPage()),

    // ---------- Shell with persistent bottom nav ----------
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<AuthCubit>()),
          BlocProvider(create: (_) => locator<VerificationCubit>()..loadStatus()),
        ],
        child: AppShell(navigationShell: navigationShell),
      ),
      branches: [
        // Branch 0 — Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (_, _) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'announcement/:id',
                  builder: (_, state) {
                    final announcement = state.extra as AnnouncementModel?;
                    if (announcement == null) return const _MissingExtraPage();
                    return AnnouncementDetailPage(announcement: announcement);
                  },
                ),
                GoRoute(
                  path: 'notifications',
                  builder: (_, _) => const NotificationsFullPage(),
                ),
              ],
            ),
          ],
        ),

        // Branch 1 — Marketplace
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.marketplace,
              builder: (_, _) => const MarketplacePage(),
              routes: [
                GoRoute(
                  path: 'app/:id',
                  builder: (_, state) =>
                      AppDetailsPage(appId: state.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),

        // Branch 2 — Wallet
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.wallet,
              builder: (_, _) => const WalletPage(),
              routes: [
                GoRoute(
                  path: 'payout',
                  builder: (_, state) {
                    final extra = state.extra! as Map<String, dynamic>;
                    final cubit = extra['cubit'] as WalletCubit;
                    return BlocProvider.value(
                      value: cubit,
                      child: PayoutPage(
                        balance: extra['balance'] as double,
                        methods: extra['methods'] as List<PayoutMethodModel>,
                        savedProfile: extra['savedProfile'] as PayoutProfileModel?,
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: 'commissions',
                  builder: (_, _) => const CommissionsPage(),
                ),
                GoRoute(
                  path: 'referrals',
                  builder: (_, _) => const ReferralsPage(),
                ),
              ],
            ),
          ],
        ),

        // Branch 3 — Support
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.support,
              builder: (_, _) => const SupportPage(),
              routes: [
                GoRoute(
                  path: 'new',
                  builder: (_, _) => const NewTicketPage(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (_, state) =>
                      TicketDetailPage(ticketId: state.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),

        // Branch 4 — Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (_, _) => const ProfilePage(),
              routes: [
                GoRoute(
                  path: 'edit',
                  builder: (_, _) => const EditProfilePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

class _MissingExtraPage extends StatelessWidget {
  const _MissingExtraPage();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.canPop()) context.pop();
    });
    return const SizedBox.shrink();
  }
}

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final token = await AppStorage.getToken();
  final isLoggedIn = token != null;
  final isOnAuthPage = state.matchedLocation == AppRoutes.login ||
      state.matchedLocation == AppRoutes.register ||
      state.matchedLocation == AppRoutes.forgotPassword;

  if (!isLoggedIn && !isOnAuthPage) return AppRoutes.login;
  if (isLoggedIn && isOnAuthPage) return AppRoutes.home;

  // One-shot deep-link from a cold-start notification tap.
  if (isLoggedIn) {
    final pending = locator<LocalNotificationService>().consumePendingRoute();
    if (pending != null) return pending;
  }

  return null;
}
