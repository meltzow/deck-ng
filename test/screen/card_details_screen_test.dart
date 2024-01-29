import 'package:deck_ng/env.dart';
import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../integration_test/Localization.dart';
import '../controller/board_details_controller_test.mocks.dart';
import '../service/auth_service_test.mocks.dart';

@GenerateMocks([ICardService, IStorageService])
void main() {
  late ICardService cardServiceMock;
  late IStorageService credentialServiceMock;

  setUp(() {
    cardServiceMock = Get.put<ICardService>(MockICardService());
    credentialServiceMock = Get.put<IStorageService>(MockIStorageService());
  });

  testWidgets('show a simple card', (tester) async {
    var resp = Account(
        username: 'admin',
        password: 'password',
        authData: 'authData',
        url: 'http://localhost',
        isAuthenticated: true);
    when(credentialServiceMock.getAccount()).thenAnswer((_) async => resp);

    var lo = await Localization.getLocalizations(tester);
    Environment.init(flavor: BuildFlavor.testing);

    await tester.pumpWidget(MyApp(debugShowCheckedModeBanner: false));
    //Get.toNamed('/cards/details');
    //await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();

    // Verify the counter starts at 0.
    expect(find.text('0'), findsOneWidget);

    // Finds the floating action button to tap on.
    final fab = find.byKey(const Key('increment'));

    // Emulate a tap on the floating action button.
    await tester.tap(fab);

    // Trigger a frame.
    await tester.pumpAndSettle();

    // Verify the counter increments by 1.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
