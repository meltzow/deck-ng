import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/controller/settings_controller.dart';
import 'package:deck_ng/model/models.dart' as nc;
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/screen/settings_screen.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:screenshots/src/capture_screen.dart';

import 'settings_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<StorageService>(),
  MockSpec<NotificationService>(),
])
void main() {
  late SettingsController controller;
  late StorageService storageServiceMock;

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    Get.testMode = true;
    Get.replace<StorageService>(MockStorageService());
    storageServiceMock = Get.find<StorageService>();
    Get.replace<NotificationService>(MockNotificationService());

    controller = SettingsController();
  });

  testWidgets('display settings screen', (WidgetTester tester) async {
    when(storageServiceMock.hasAccount()).thenReturn(true);
    when(storageServiceMock.getAccount()).thenReturn(nc.Account(
        username: 'foo',
        password: 'ddd',
        authData: 'authData',
        url: 'url',
        isAuthenticated: true));

    when(storageServiceMock.hasSettings()).thenReturn(true);
    when(storageServiceMock.getSetting()).thenReturn(nc.Setting('english'));

    Get.lazyReplace<SettingsController>(() => controller);

    await tester.pumpWidget(MyApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.settings,
        initialPages: [
          GetPage(
            parameters: {},
            name: AppRoutes.settings,
            page: () => SettingScreen(),
          )
        ]));
    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await screenshot(binding, tester, 'settings_screen');
  });
}
