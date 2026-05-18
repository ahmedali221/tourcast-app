import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/storage/app_storage.dart';

// Placeholder screens — replace with real pages as features are built.
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
import 'package:tourguide_app/features/notifications/view/notifications_page.dart';
// import 'package:tourguide_app/features/knowledge_center/view/knowledge_center_page.dart'; // OUT OF SCOPE — Phase 2
import 'package:tourguide_app/features/agreements/view/agreements_page.dart';
import 'package:tourguide_app/features/home/view/home_page.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  redirect: _redirect,
  routes: [
    // ---------- Auth ----------
    GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginPage()),
    GoRoute(path: AppRoutes.register, builder: (_, _) => const RegisterPage()),
    GoRoute(path: AppRoutes.forgotPassword, builder: (_, _) => const ForgotPasswordPage()),
    GoRoute(path: AppRoutes.verifyEmail, builder: (_, _) => const VerifyEmailPage()),

    // ---------- Main ----------
    GoRoute(path: AppRoutes.home, builder: (_, _) => const HomePage()),

    // ---------- Profile ----------
    GoRoute(path: AppRoutes.profile, builder: (_, _) => const ProfilePage()),
    GoRoute(path: AppRoutes.editProfile, builder: (_, _) => const EditProfilePage()),

    // ---------- Verification ----------
    GoRoute(path: AppRoutes.verification, builder: (_, _) => const VerificationPage()),
    GoRoute(path: AppRoutes.verificationSuccess, builder: (_, _) => const VerificationSuccessPage()),

    // ---------- Marketplace ----------
    GoRoute(path: AppRoutes.marketplace, builder: (_, _) => const MarketplacePage()),
    GoRoute(
      path: AppRoutes.appDetails,
      builder: (_, state) => AppDetailsPage(appId: state.pathParameters['id']!),
    ),

    // ---------- Wallet & Finance ----------
    GoRoute(path: AppRoutes.wallet, builder: (_, _) => const WalletPage()),
    GoRoute(
      path: AppRoutes.payout,
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
    GoRoute(path: AppRoutes.commissions, builder: (_, _) => const CommissionsPage()),
    GoRoute(path: AppRoutes.referrals, builder: (_, _) => const ReferralsPage()),

    // ---------- Support ----------
    GoRoute(path: AppRoutes.support, builder: (_, _) => const SupportPage()),
    GoRoute(path: AppRoutes.newTicket, builder: (_, _) => const NewTicketPage()),
    GoRoute(
      path: AppRoutes.ticketDetail,
      builder: (_, state) => TicketDetailPage(ticketId: state.pathParameters['id']!),
    ),

    // ---------- Notifications ----------
    GoRoute(path: AppRoutes.notifications, builder: (_, _) => const NotificationsPage()),

    // ---------- Knowledge Center — OUT OF SCOPE Phase 2 ----------
    // GoRoute(path: AppRoutes.knowledgeCenter, builder: (_, _) => const KnowledgeCenterPage()),

    // ---------- Agreements ----------
    GoRoute(path: AppRoutes.agreements, builder: (_, _) => const AgreementsPage()),
  ],
);

// Redirect unauthenticated users to login.
Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final token = await AppStorage.getToken();
  final isLoggedIn = token != null;
  final isOnAuthPage = state.matchedLocation == AppRoutes.login ||
      state.matchedLocation == AppRoutes.register ||
      state.matchedLocation == AppRoutes.forgotPassword;

  if (!isLoggedIn && !isOnAuthPage) return AppRoutes.login;
  if (isLoggedIn && isOnAuthPage) return AppRoutes.home;
  return null;
}
