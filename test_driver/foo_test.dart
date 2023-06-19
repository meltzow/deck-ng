//test_driver/foo_test.dart
import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

// Future<void> main() async {
//   final FlutterDriver driver = await FlutterDriver.connect();
//   await integrationDriver(
//     driver: driver,
//     onScreenshot: (String screenshotName, List<int> screenshotBytes,
//         [args]) async {
//       final File image = await File(screenshotName).create(recursive: true);
//       image.writeAsBytesSync(screenshotBytes);
//       return true;
//     },
//   );
// }
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
