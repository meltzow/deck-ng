import 'package:deck_ng/controller/login_controller.dart';
import 'package:deck_ng/screen/login_screen.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_screen_test.mocks.dart';

class MockLoginController extends GetxController
    with Mock
    implements LoginController {
  RxString url = ''.obs;
  var isUrlValid = false.obs;
  var username = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = false.obs;
  var urlController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var serverInfo = ''.obs;
  var isLoading = false.obs;

  final focusNode = FocusNode();
}

@GenerateMocks([StorageService, AuthService, NotificationService])
void main() {
  late LoginController loginController;
  late StorageService storageServiceMock;
  late AuthService authServiceMock;
  late NotificationService notificationServiceMock;

  setUp(() {
    Get.testMode = true;

    authServiceMock = Get.put<AuthService>(MockAuthService());
    storageServiceMock = Get.put<StorageService>(MockStorageService());
    notificationServiceMock =
        Get.put<NotificationService>(MockNotificationService());

    loginController = MockLoginController();
    Get.put<LoginController>(loginController);
  });

  tearDown(() {
    loginController.onClose();
    Get.reset();
  });

  testWidgets('LoginScreen test', (WidgetTester tester) async {
    // Stub the login method to return a Future that completes with true.
    when(loginController.login()).thenAnswer((_) => Future.value(true));
    // Build our app and trigger a frame.
    await tester.pumpWidget(GetMaterialApp(home: LoginScreen()));

    // Verify that the login screen is shown.
    expect(find.text('Welcome back to deck NG!'), findsOneWidget);

    // Simulate user interactions
    await tester.enterText(
        find.byType(TextField).first, 'https://foobar.de:8990/nextcloud');
    await tester.enterText(find.byType(TextField).at(1), 'username');
    await tester.enterText(find.byType(TextField).at(2), 'password');

    // Tap the login button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that the login method was called.
    verify(loginController.login()).called(1);
  });
}
