import 'package:flutter/material.dart';
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
import 'package:tourguide_app/features/marketplace/view/marketplace_page.dart';
import 'package:tourguide_app/features/wallet/view/wallet_page.dart';
import 'package:tourguide_app/features/commissions/view/commissions_page.dart';
import 'package:tourguide_app/features/referrals/view/referrals_page.dart';
import 'package:tourguide_app/features/support/view/support_page.dart';
import 'package:tourguide_app/features/support/view/new_ticket_page.dart';
import 'package:tourguide_app/features/support/view/ticket_detail_page.dart';
import 'package:tourguide_app/features/notifications/view/notifications_page.dart';
import 'package:tourguide_app/features/knowledge_center/view/knowledge_center_page.dart';
import 'package:tourguide_app/features/agreements/view/agreements_page.dart';
import 'package:tourguide_app/features/home/view/home_page.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  redirect: _redirect,
  routes: [
    // ---------- Auth ----------
    GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginPage()),
    GoRoute(path: AppRoutes.register, builder: (_, __) => const RegisterPage()),
    GoRoute(path: AppRoutes.forgotPassword, builder: (_, __) => const ForgotPasswordPage()),
    GoRoute(path: AppRoutes.verifyEmail, builder: (_, __) => const VerifyEmailPage()),

    // ---------- Main ----------
    GoRoute(path: AppRoutes.home, builder: (_, __) => const HomePage()),

    // ---------- Profile ----------
    GoRoute(path: AppRoutes.profile, builder: (_, __) => const ProfilePage()),
    GoRoute(path: AppRoutes.editProfile, builder: (_, __) => const EditProfilePage()),

    // ---------- Verification ----------
    GoRoute(path: AppRoutes.verification, builder: (_, __) => const VerificationPage()),

    // ---------- Marketplace ----------
    GoRoute(path: AppRoutes.marketplace, builder: (_, __) => const MarketplacePage()),

    // ---------- Wallet & Finance ----------
    GoRoute(path: AppRoutes.wallet, builder: (_, __) => const WalletPage()),
    GoRoute(path: AppRoutes.commissions, builder: (_, __) => const CommissionsPage()),
    GoRoute(path: AppRoutes.referrals, builder: (_, __) => const ReferralsPage()),

    // ---------- Support ----------
    GoRoute(path: AppRoutes.support, builder: (_, __) => const SupportPage()),
    GoRoute(path: AppRoutes.newTicket, builder: (_, __) => const NewTicketPage()),
    GoRoute(
      path: AppRoutes.ticketDetail,
      builder: (_, state) => TicketDetailPage(ticketId: state.pathParameters['id']!),
    ),

    // ---------- Notifications ----------
    GoRoute(path: AppRoutes.notifications, builder: (_, __) => const NotificationsPage()),

    // ---------- Knowledge Center ----------
    GoRoute(path: AppRoutes.knowledgeCenter, builder: (_, __) => const KnowledgeCenterPage()),

    // ---------- Agreements ----------
    GoRoute(path: AppRoutes.agreements, builder: (_, __) => const AgreementsPage()),
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
