import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

// Central service locator.
// Call setupLocator() once in main() before runApp().
final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // --- External ---
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );

  // Add feature-specific services/repos here as you build them.
  // Example:
  // locator.registerLazySingleton(() => AuthService());
}
