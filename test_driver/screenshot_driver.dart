import 'package:integration_test/integration_test_driver_extended.dart';
import 'package:screenshots/src/screenshot_handler.dart';

Future<void> main() async {
  await integrationDriver(
      onScreenshot: (String screenshotName, List<int> screenshotBytes,
              [args]) async =>
          screenshotHandler(screenshotName, screenshotBytes));
}
