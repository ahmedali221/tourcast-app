import 'package:flutter/material.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/router/app_router.dart';
import 'package:tourguide_app/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up all service locator registrations.
  await setupLocator();

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
