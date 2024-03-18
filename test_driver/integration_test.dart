import 'dart:io';

import 'package:flutter_driver/driver_extension.dart';
import 'package:integration_test/integration_test_driver_extended.dart';
import 'package:deck_ng/main.dart' as app;

Future<void> main() async {
  try {
    await integrationDriver(
      onScreenshot: (String screenshotName, List<int> screenshotBytes,
          [args]) async {
        final File image = await File('screenshots/$screenshotName.png')
            .create(recursive: true);
        image.writeAsBytesSync(screenshotBytes);
        return true;
      },
    );
  } catch (e) {
    print('Error occured: $e');
  }
}
