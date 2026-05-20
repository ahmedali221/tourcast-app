import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tourguide_app/core/network/api_client.dart';
import 'package:tourguide_app/core/notifications/local_notification_service.dart';

// --- Feature Repositories (interfaces) ---
import 'package:tourguide_app/features/agreements/repository/i_agreements_repository.dart';
import 'package:tourguide_app/features/auth/repository/i_auth_repository.dart';
import 'package:tourguide_app/features/commissions/repository/i_commissions_repository.dart';
// import 'package:tourguide_app/features/knowledge_center/repository/i_knowledge_center_repository.dart'; // OUT OF SCOPE — Phase 2
import 'package:tourguide_app/features/marketplace/repository/i_marketplace_repository.dart';
import 'package:tourguide_app/features/announcements/repository/i_announcements_repository.dart';
import 'package:tourguide_app/features/notifications/repository/i_notifications_repository.dart';
import 'package:tourguide_app/features/profile/repository/i_profile_repository.dart';
import 'package:tourguide_app/features/referrals/repository/i_referrals_repository.dart';
// import 'package:tourguide_app/features/subscription/repository/i_subscription_repository.dart'; // OUT OF SCOPE — Phase 2
import 'package:tourguide_app/features/support/repository/i_support_repository.dart';
import 'package:tourguide_app/features/verification/repository/i_verification_repository.dart';
import 'package:tourguide_app/features/wallet/repository/i_wallet_repository.dart';

// --- Feature Repositories (implementations) ---
import 'package:tourguide_app/features/agreements/repository/agreements_repository.dart';
import 'package:tourguide_app/features/auth/repository/auth_repository.dart';
import 'package:tourguide_app/features/commissions/repository/commissions_repository.dart';
// import 'package:tourguide_app/features/knowledge_center/repository/knowledge_center_repository.dart'; // OUT OF SCOPE — Phase 2
import 'package:tourguide_app/features/marketplace/repository/marketplace_repository.dart';
import 'package:tourguide_app/features/announcements/repository/announcements_repository.dart';
import 'package:tourguide_app/features/notifications/repository/notifications_repository.dart';
import 'package:tourguide_app/features/profile/repository/profile_repository.dart';
import 'package:tourguide_app/features/referrals/repository/referrals_repository.dart';
// import 'package:tourguide_app/features/subscription/repository/subscription_repository.dart'; // OUT OF SCOPE — Phase 2
import 'package:tourguide_app/features/support/repository/support_repository.dart';
import 'package:tourguide_app/features/verification/repository/verification_repository.dart';
import 'package:tourguide_app/features/wallet/repository/wallet_repository.dart';

// --- Cubits (ViewModels) ---
import 'package:tourguide_app/features/agreements/viewmodel/agreements_cubit.dart';
import 'package:tourguide_app/features/auth/viewmodel/auth_cubit.dart';
import 'package:tourguide_app/features/commissions/viewmodel/commissions_cubit.dart';
// import 'package:tourguide_app/features/knowledge_center/viewmodel/knowledge_center_cubit.dart'; // OUT OF SCOPE — Phase 2
import 'package:tourguide_app/features/home/viewmodel/home_promo_codes_cubit.dart';
import 'package:tourguide_app/features/marketplace/viewmodel/marketplace_cubit.dart';
import 'package:tourguide_app/features/announcements/viewmodel/announcements_cubit.dart';
import 'package:tourguide_app/features/notifications/viewmodel/notifications_cubit.dart';
import 'package:tourguide_app/features/profile/viewmodel/profile_cubit.dart';
import 'package:tourguide_app/features/referrals/viewmodel/referrals_cubit.dart';
// import 'package:tourguide_app/features/subscription/viewmodel/subscription_cubit.dart'; // OUT OF SCOPE — Phase 2
import 'package:tourguide_app/features/support/viewmodel/support_cubit.dart';
import 'package:tourguide_app/features/verification/viewmodel/verification_cubit.dart';
import 'package:tourguide_app/features/wallet/viewmodel/wallet_cubit.dart';

// Global service locator instance.
final GetIt locator = GetIt.instance;

/// Call this once in main() before runApp().
/// Registration order: external → repositories → cubits
Future<void> setupLocator() async {
  // ----------------------------------------------------------------
  // 1. EXTERNAL / INFRASTRUCTURE
  // ----------------------------------------------------------------

  // The single Dio instance shared by every repository.
  locator.registerSingleton<Dio>(ApiClient.dio);

  locator.registerLazySingleton<LocalNotificationService>(
    () => LocalNotificationService(),
  );

  // ----------------------------------------------------------------
  // 2. REPOSITORIES
  // Registered as LazySingleton: created once, reused across the app.
  // Cubits depend on the abstract interface (IXxx), not the concrete class.
  // ----------------------------------------------------------------

  locator.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(locator()),
  );

  locator.registerLazySingleton<IProfileRepository>(
    () => ProfileRepository(locator()),
  );

  locator.registerLazySingleton<IVerificationRepository>(
    () => VerificationRepository(locator()),
  );

  locator.registerLazySingleton<IMarketplaceRepository>(
    () => MarketplaceRepository(locator()),
  );

  // OUT OF SCOPE — Phase 2
  // locator.registerLazySingleton<ISubscriptionRepository>(
  //   () => SubscriptionRepository(locator()),
  // );

  locator.registerLazySingleton<IWalletRepository>(
    () => WalletRepository(locator()),
  );

  locator.registerLazySingleton<ICommissionsRepository>(
    () => CommissionsRepository(locator()),
  );

  locator.registerLazySingleton<IReferralsRepository>(
    () => ReferralsRepository(locator()),
  );

  locator.registerLazySingleton<ISupportRepository>(
    () => SupportRepository(locator()),
  );

  locator.registerLazySingleton<INotificationsRepository>(
    () => NotificationsRepository(locator()),
  );

  locator.registerLazySingleton<IAnnouncementsRepository>(
    () => AnnouncementsRepository(locator()),
  );

  // OUT OF SCOPE — Phase 2
  // locator.registerLazySingleton<IKnowledgeCenterRepository>(
  //   () => KnowledgeCenterRepository(locator()),
  // );

  locator.registerLazySingleton<IAgreementsRepository>(
    () => AgreementsRepository(locator()),
  );

  // ----------------------------------------------------------------
  // 3. CUBITS (ViewModels)
  // Registered as Factory: a fresh instance is created on every use.
  // Each cubit receives its repository interface via locator().
  // ----------------------------------------------------------------

  locator.registerFactory(() => AuthCubit(locator()));
  locator.registerFactory(() => ProfileCubit(locator()));
  locator.registerFactory(() => VerificationCubit(locator()));
  locator.registerFactory(() => MarketplaceCubit(locator()));
  locator.registerFactory(() => HomePromoCodesCubit(locator()));
  // locator.registerFactory(() => SubscriptionCubit(locator())); // OUT OF SCOPE — Phase 2
  locator.registerFactory(() => WalletCubit(locator()));
  locator.registerFactory(() => CommissionsCubit(locator()));
  locator.registerFactory(() => ReferralsCubit(locator()));
  locator.registerFactory(() => SupportCubit(locator()));
  locator.registerFactory(() => NotificationsCubit(locator()));
  locator.registerFactory(() => AnnouncementsCubit(locator()));
  // locator.registerFactory(() => KnowledgeCenterCubit(locator())); // OUT OF SCOPE — Phase 2
  locator.registerFactory(() => AgreementsCubit(locator()));
}
