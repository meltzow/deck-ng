/// This file contains the tests that take screenshots of the app.
///
/// Run it with `flutter test --update-goldens` to generate the screenshots
/// or `flutter test` to compare the screenshots to the golden files.
library;

import 'package:deck_ng/dashboard/dashboard_controller.dart';
import 'package:deck_ng/dashboard/dashboard_screen.dart';
import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/services.dart';
import 'package:deck_ng/service/tracking_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:golden_screenshot/golden_screenshot.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'screenshot_test.mocks.dart';

@GenerateMocks(
    [BoardService, StackService, CardService, TrackingService, AuthService])
void main() {
  Get.testMode = true;
  Get.replace<BoardService>(MockBoardService());
  var boardServiceMock = Get.find<BoardService>();
  Get.replace<CardService>(MockCardService());
  var cardServiceMock = Get.find<CardService>();
  Get.replace<StackService>(MockStackService());
  var stackServiceMock = Get.find<StackService>();
  Get.replace<TrackingService>(MockTrackingService());
  var trackingServiceMock = Get.find<TrackingService>();
  Get.replace<AuthService>(MockAuthService());
  var authServiceMock = Get.find<AuthService>();

  group('Screenshot:', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;

    var board1 = Board(title: 'garden', id: 1);
    var resp = [board1];
    when(boardServiceMock.getAllBoards()).thenAnswer((_) async => resp);

    final homePageTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    );
    final homePageFrameColors = ScreenshotFrameColors(
      topBar: homePageTheme.colorScheme.inversePrimary,
      bottomBar: homePageTheme.colorScheme.surface,
    );

    // Injiziere den Mock-Controller
    final controller = DashboardController();
    controller.boards.value = resp;
    Get.put<DashboardController>(controller);

    _screenshotWidget(
      counter: 100,
      frameColors: homePageFrameColors,
      theme: homePageTheme,
      goldenFileName: '1_counter_100',
      child: DashboardScreen(
          // title: 'Golden screenshot demo',
          ),
    );

    _screenshotWidget(
      counter: 998,
      frameColors: homePageFrameColors,
      theme: homePageTheme,
      goldenFileName: '2_counter_998',
      child: DashboardScreen(
          // title: 'Golden screenshot demo',
          ),
    );

    _screenshotWidget(
      counter: 998,
      frameColors: homePageFrameColors,
      theme: homePageTheme,
      goldenFileName: '3_dialog',
      child: DashboardScreen(
          // title: 'Golden screenshot dialog demo',
          // showDialog: true,
          ),
    );
  });
}

void _screenshotWidget({
  int counter = 0,
  ScreenshotFrameColors? frameColors,
  ThemeData? theme,
  required String goldenFileName,
  required Widget child,
}) {
  group(goldenFileName, () {
    for (final goldenDevice in GoldenScreenshotDevices.values) {
      testWidgets('for ${goldenDevice.name}', (tester) async {
        final device = goldenDevice.device;

        // Enable shadows which are normally disabled in golden tests.
        // Make sure to disable them again at the end of the test.
        debugDisableShadows = false;

        final widget = ScreenshotApp(
          theme: theme,
          device: device,
          frameColors: frameColors,
          child: child,
        );
        await tester.pumpWidget(widget);

        // await tester.pumpAndSettle();

        // Precache the images and fonts
        // so they're ready for the screenshot.
        await tester.precacheImagesInWidgetTree();
        await tester.precacheTopbarImages();
        await tester.loadFonts();

        // Pump the widget for a second to ensure animations are complete.
        await tester.pumpFrames(widget, const Duration(seconds: 1));

        // Take the screenshot and compare it to the golden file.
        await tester.expectScreenshot(device, goldenFileName);

        debugDisableShadows = true;
      });
    }
  });
}
