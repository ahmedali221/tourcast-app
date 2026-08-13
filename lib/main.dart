import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/localization/locale_cubit.dart';
import 'package:tourguide_app/core/notifications/local_notification_service.dart';
import 'package:tourguide_app/core/router/app_router.dart';
import 'package:tourguide_app/core/sync/background_sync.dart';
import 'package:tourguide_app/core/sync/sync_keys.dart';
import 'package:tourguide_app/core/theme/app_theme.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up all service locator registrations.
  await setupLocator();

  // Init local notification service: creates Android channel, wires tap handlers,
  // and reads any cold-start pending route set by onBackgroundNotificationResponse.
  final notifService = locator<LocalNotificationService>();
  await notifService.init();
  await notifService.requestPermission();

  // Register WorkManager periodic background sync.
  // ExistingWorkPolicy.keep avoids re-scheduling on every app launch.
  await Workmanager().initialize(backgroundSyncDispatcher);

  // Notifications sync: always on, fixed hourly cadence.
  await Workmanager().registerPeriodicTask(
    notifSyncUniqueName,
    notifSyncTaskName,
    frequency: const Duration(hours: 1),
    constraints: Constraints(networkType: NetworkType.connected),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
  );

  // Ticket sync: only scheduled while a ticket is open, restored here from
  // the state SupportCubit last persisted (see updateTicketSyncSchedule).
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool(SyncKeys.hasOpenTicket) ?? false) {
    await Workmanager().registerPeriodicTask(
      ticketSyncUniqueName,
      ticketSyncTaskName,
      frequency: ticketSyncFrequency,
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    );
  }

  // Drop the old combined task registered by previous app versions.
  await Workmanager().cancelByUniqueName('niletech_bg_sync');

  // Forward foreground/background notification taps directly to GoRouter.
  notifService.onTap.listen((route) => appRouter.go(route));

  runApp(const NileTechApp());
}

class NileTechApp extends StatelessWidget {
  const NileTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleCubit>(
      create: (_) => locator<LocaleCubit>(),
      child: BlocBuilder<LocaleCubit, Locale?>(
        builder: (context, locale) {
          return MaterialApp.router(
            title: 'NileTech Tour Guide',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            routerConfig: appRouter,
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
