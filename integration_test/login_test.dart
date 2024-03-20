import 'dart:convert';

import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Inotification_service.dart';
import 'package:deck_ng/service/Istorage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:screenshots/src/capture_screen.dart';

import 'login_test.mocks.dart';

@GenerateMocks([IAuthService, IStorageService, INotificationService])
void main() {
  IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    late IAuthService authServiceMock;

    Get.replace<IAuthService>(MockIAuthService());
    authServiceMock = Get.find<IAuthService>();

    Get.replace<IStorageService>(MockIStorageService());
    var storageServiceMock = Get.find<IStorageService>();

    Get.replace<INotificationService>(MockINotificationService());
    //var storageServiceMock = Get.find<IStorageService>();

    when(storageServiceMock.getAccount()).thenReturn(null);
    when(storageServiceMock.hasAccount()).thenReturn(false);
    when(storageServiceMock.saveAccount(Account(
            "admin",
            "admin",
            'Basic ${base64.encode(utf8.encode('admin:admin'))}',
            "http://192.168.178.81:8080",
            false)))
        .thenReturn(null);

    when(storageServiceMock.hasSettings()).thenReturn(false);

    var resp = Capabilities(CapabilitiesOcs(
        meta: Meta('success', 200, 'success'),
        data: CapabilitiesData(Version(0, 0, 26, "26.0.0", '', false), {})));
    when(authServiceMock.checkServer('https://my.next.cloud'))
        .thenAnswer((_) async => resp);
    when(authServiceMock.isAuth()).thenReturn(false);
  });

  testWidgets('display login screen', (tester) async {
    await tester.pumpWidget(MyApp(debugShowCheckedModeBanner: false));

    await tester.enterText(
        find.byKey(const Key('serverUrl')), 'https://my.next.cloud');
    await tester.enterText(find.byKey(const Key('username')), 'deckNG');
    await tester.enterText(find.byKey(const Key('password')), 'secret');
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);
    await tester.pumpAndSettle();
    await screenshot(binding, tester, '1');
  });
}
