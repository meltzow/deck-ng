import 'dart:convert';

import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:deck_ng/env.dart';
import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Inotification_service.dart';
import 'package:deck_ng/service/Istorage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';
import 'main_test.dart';

@GenerateMocks([IAuthService, IStorageService, INotificationService])
void main() {
  convenientTestMain(MyConvenientTestSlot(), () {
    group('simple test group', () {
      late IntegrationTestWidgetsFlutterBinding binding;
      setUp(() async {
        late IAuthService authServiceMock;
        binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

        Get.replace<IAuthService>(MockIAuthService());
        authServiceMock = Get.find<IAuthService>();

        Get.replace<IStorageService>(MockIStorageService());
        var storageServiceMock = Get.find<IStorageService>();

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

        Environment.init();

        var resp = Capabilities(CapabilitiesOcs(
            meta: Meta('success', 200, 'success'),
            data:
                CapabilitiesData(Version(0, 0, 26, "26.0.0", '', false), {})));
        when(authServiceMock.checkServer('https://my.next.cloud'))
            .thenAnswer((_) async => resp);
        when(authServiceMock.isAuth()).thenReturn(false);
      });

      tTestWidgets('display login screen', (ConvenientTest tester) async {
        // await tester.pumpWidget(MyApp(debugShowCheckedModeBanner: false));
        await Future.delayed(const Duration(seconds: 1), () {});
        await tester.pumpAndSettle();
        await find.text('sign in').should(findsOneWidget);

        await find
            .byKey(const Key('serverUrl'))
            .replaceText('https://my.next.cloud');
        await find.byKey(const Key('username')).replaceText('deckNG');
        await find.byKey(const Key('password')).replaceText('secret');
        await tester.pumpAndSettle();
        await find.text('Login').should(findsOneWidget);

        // then you want to log and snapshot
        final log =
            tester.log('HELLO', 'Just a demonstration of custom logging');
        await log.snapshot();
      });
    });
  });
}
