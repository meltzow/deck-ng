import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

class Localization {
  static Future<AppLocalizations> getLocalizations(WidgetTester t) async {
    late AppLocalizations result;
    await t.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              result = AppLocalizations.of(context)!;
              return Container();
            },
          ),
        ),
      ),
    );
    return result;
  }
}
