import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  try {
    await integrationDriver(
      onScreenshot: (String screenshotName, List<int> screenshotBytes,
          [args]) async {
        final image = await File('screenshots/$screenshotName.png')
            .create(recursive: true);
        image.writeAsBytesSync(screenshotBytes);
        // Return false if the screenshot is invalid.
        return true;
      },
    );
  } catch (e) {
    print('Error occurred: $e');
  }
}
