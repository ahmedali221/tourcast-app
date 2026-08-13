import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('loads the English localization catalog', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) =>
              Scaffold(body: Text(AppLocalizations.of(context).appTitle)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('NileTech Tour Guide'), findsOneWidget);
  });
}
