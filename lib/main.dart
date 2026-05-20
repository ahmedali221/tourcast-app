import 'package:flutter/material.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/notifications/local_notification_service.dart';
import 'package:tourguide_app/core/router/app_router.dart';
import 'package:tourguide_app/core/sync/background_sync.dart';
import 'package:tourguide_app/core/theme/app_theme.dart';
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
  await Workmanager().registerPeriodicTask(
    'niletech_bg_sync',
    'syncTask',
    frequency: const Duration(hours: 1),
    constraints: Constraints(networkType: NetworkType.connected),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
  );

  // Forward foreground/background notification taps directly to GoRouter.
  notifService.onTap.listen((route) => appRouter.go(route));

  runApp(const NileTechApp());
}

class NileTechApp extends StatelessWidget {
  const NileTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NileTech Tour Guide',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
