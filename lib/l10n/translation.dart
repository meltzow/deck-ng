import 'dart:ui';

import 'package:deck_ng/l10n/de_de.dart';
import 'package:deck_ng/l10n/en_us.dart';
import 'package:get/get.dart';

class Translation extends Translations {
  Locale locale = const Locale('en', 'US');

  static final List appLanguages = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Deutsch', 'locale': const Locale('de', 'DE')},
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': EnUs().messages,
        'de_DE': DeDe().messages,
      };
}
