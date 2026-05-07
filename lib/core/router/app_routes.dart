class AppRoutes {
  AppRoutes._();

  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String verifyEmail = '/verify-email';

  // Main shell (bottom nav)
  static const String home = '/home';

  // Profile
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';

  // Verification
  static const String verification = '/verification';

  // Marketplace
  static const String marketplace = '/marketplace';
  static const String appDetails = '/marketplace/app/:id';
  static const String subscribe = '/marketplace/subscribe';

  // Wallet & Finance
  static const String wallet = '/wallet';
  static const String commissions = '/commissions';
  static const String referrals = '/referrals';
  static const String payout = '/wallet/payout';

  // Support
  static const String support = '/support';
  static const String newTicket = '/support/new';
  static const String ticketDetail = '/support/:id';

  // Notifications
  static const String notifications = '/notifications';

  // Knowledge Center
  static const String knowledgeCenter = '/knowledge-center';
  static const String article = '/knowledge-center/article/:id';

  // Agreements
  static const String agreements = '/agreements';
}
