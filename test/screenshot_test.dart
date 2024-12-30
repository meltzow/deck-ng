import 'package:deck_ng/board_details/kanban_board_controller.dart';
import 'package:deck_ng/board_details/kanban_board_screen.dart';
import 'package:deck_ng/card_details/card_details_controller.dart';
import 'package:deck_ng/card_details/card_details_screen.dart';
import 'package:deck_ng/home/dashboard_controller.dart';
import 'package:deck_ng/home/dashboard_screen.dart';
import 'package:deck_ng/login/login_controller.dart';
import 'package:deck_ng/login/login_screen.dart';
import 'package:deck_ng/model/models.dart' as nc;
import 'package:deck_ng/service/services.dart';
import 'package:deck_ng/service/tracking_service.dart';
import 'package:deck_ng/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:golden_screenshot/golden_screenshot.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'screenshot_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<StorageService>(),
  MockSpec<BoardService>(),
  MockSpec<StackService>(),
  MockSpec<CardService>(),
  MockSpec<NotificationService>(),
  MockSpec<AuthService>(),
  MockSpec<TrackingService>(),
  MockSpec<DashboardController>()
])

// Declare the mocks as global variables
late StorageService storageServiceMock;
late BoardService boardServiceMock;
late StackService stackServiceMock;
late CardService cardServiceMock;
late AuthService authServiceMock;
late TrackingService trackingServiceMock;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  ScreenshotDevice.screenshotsFolder =
      '../android/fastlane/metadata/android/\$langCode/images/';

  setUpAll(() {
    Get.testMode = true;
    storageServiceMock = Get.put<StorageService>(MockStorageService());
    boardServiceMock = Get.put<BoardService>(MockBoardService());
    cardServiceMock = Get.put<CardService>(MockCardService());
    stackServiceMock = Get.put<StackService>(MockStackService());
    authServiceMock = Get.put<AuthService>(MockAuthService());
    trackingServiceMock = Get.put<TrackingService>(MockTrackingService());
    Get.put<NotificationService>(MockNotificationService());
  });

  group('Screenshot:', () {
    final homePageTheme = myTheme;
    final homePageFrameColors = ScreenshotFrameColors(
      topBar: homePageTheme.colorScheme.inversePrimary,
      bottomBar: homePageTheme.colorScheme.surface,
    );

    // testWidgets('01_login', (tester) async {
    //   await _testLoginScreen(tester, homePageTheme, homePageFrameColors);
    // });

    testWidgets('02_dashboard', (tester) async {
      await _testDashboardScreen(tester, homePageTheme, homePageFrameColors);
    });

    // testWidgets('03_boarddetails', (tester) async {
    //   await _testBoardDetailsScreen(tester, homePageTheme, homePageFrameColors);
    // });
    //
    // testWidgets('04_carddetails', (tester) async {
    //   await _testCardDetailsScreen(tester, homePageTheme, homePageFrameColors);
    // });
  });
}

Future<void> _testLoginScreen(WidgetTester tester, ThemeData theme,
    ScreenshotFrameColors frameColors) async {
  when(storageServiceMock.getAccount()).thenReturn(null);
  when(storageServiceMock.hasAccount()).thenReturn(false);
  when(storageServiceMock.hasSettings()).thenReturn(false);

  final controller = LoginController();
  controller.nextcloudVersionString = '30.0.0'.obs;
  controller.isUrlValid = true.obs;
  controller.isFormValid = true.obs;
  controller.urlController.text = "https://my.next.cloud";
  controller.userNameController.text = "user";
  controller.passwordController.text = "password";
  Get.put<LoginController>(controller);

  await _screenshotWidget(
      tester: tester,
      frameColors: frameColors,
      theme: theme,
      goldenFileName: '01_login',
      child: LoginScreen());
}

Future<void> _testDashboardScreen(WidgetTester tester, ThemeData theme,
    ScreenshotFrameColors frameColors) async {
  var board1 = nc.Board(title: 'garden', id: 1);
  final dashCtl = MockDashboardController();

  when(dashCtl.boards).thenReturn([board1].obs);
  Get.testMode = true;
  Get.put<DashboardController>(dashCtl);

  await _screenshotWidget(
    tester: tester,
    frameColors: frameColors,
    theme: theme,
    goldenFileName: '02_dashboard',
    child: DashboardScreen(),
  );
}

Future<void> _testBoardDetailsScreen(WidgetTester tester, ThemeData theme,
    ScreenshotFrameColors frameColors) async {
  var board2 = nc.Board(title: 'garden', id: 1);
  var ctl3 = KanbanBoardController();
  ctl3.boardsData.value = board2;
  Get.put<KanbanBoardController>(ctl3);

  await _screenshotWidget(
    tester: tester,
    frameColors: frameColors,
    theme: theme,
    goldenFileName: '03_boarddetails',
    child: KanbanBoardScreen(),
  );
}

Future<void> _testCardDetailsScreen(WidgetTester tester, ThemeData theme,
    ScreenshotFrameColors frameColors) async {
  var board3 = nc.Board(title: 'garden', id: 1);
  var stack1 = nc.Stack(title: 'todo', boardId: board3.id, id: 1);
  var card1 = nc.Card(
      title: 'seeding carrots',
      id: 1,
      stackId: stack1.id,
      description:
          '# How To Seed Carrots? \n\n1. Dig a hole\n2. Put the seed in\n3. Cover the hole');
  stack1.cards = [card1];

  var ctl1 = CardDetailsController();
  ctl1.board.value = board3;
  ctl1.card.value = card1;
  Get.put<CardDetailsController>(ctl1);

  await _screenshotWidget(
    tester: tester,
    frameColors: frameColors,
    theme: theme,
    goldenFileName: '04_carddetails',
    child: CardDetailsScreen(),
  );
}

Future<void> _screenshotWidget({
  required WidgetTester tester,
  ScreenshotFrameColors? frameColors,
  ThemeData? theme,
  required String goldenFileName,
  required Widget child,
}) async {
  for (final locale in const [
    Locale('en', 'GB'), // English
    Locale('de', 'DE'), // German
  ]) {
    for (final goldenDevice in MyAndroidDevices.values) {
      final device = goldenDevice.device;

      debugDisableShadows = false;

      final widget = ScreenshotApp(
        theme: theme,
        device: device,
        // frameColors: frameColors,
        locale: locale,
        supportedLocales: const [
          Locale('en'), // English
          Locale('de'), // German
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        child: child,
      );
      await tester.pumpWidget(widget);

      await tester.precacheImagesInWidgetTree();
      await tester.precacheTopbarImages();
      await tester.loadFonts();

      await tester.pumpFrames(widget, const Duration(seconds: 1));

      await tester.expectScreenshot(device, goldenFileName,
          langCode: '${locale.languageCode}-${locale.countryCode!}');

      debugDisableShadows = true;
    }
  }
}

enum MyAndroidDevices {
  pixel4(ScreenshotDevice(
    platform: TargetPlatform.android,
    resolution: Size(1080, 2280),
    pixelRatio: 3 / 1,
    goldenSubFolder: 'phoneScreenshots/',
    frameBuilder: ScreenshotFrame.android,
  )),

  nexus9(ScreenshotDevice(
    platform: TargetPlatform.android,
    resolution: Size(2048, 1536),
    pixelRatio: 2 / 1,
    goldenSubFolder: 'tenInchScreenshots/',
    frameBuilder: ScreenshotFrame.android,
  ));

  const MyAndroidDevices(this.device);
  final ScreenshotDevice device;
}
