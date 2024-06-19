import 'dart:ui';

import 'package:deck_ng/l10n/de_de.dart';
import 'package:deck_ng/l10n/en_us.dart';
import 'package:get/get.dart';

class Translation extends Translations {
  static final List appLanguages = [
    {'name': 'English', 'locale': const Locale('en_GB')},
    {'name': 'Deutsch', 'locale': const Locale('de_DE')},
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_GB': EnUs().messages,
        'de_DE': DeDe().messages,
      };
}
