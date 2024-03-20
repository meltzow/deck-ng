import 'package:deck_ng/controller/card_details_controller.dart';
import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:deck_ng/service/Istorage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([CardDetailsController])
void main() {
  late CardDetailsController cardDetailsControllerMock;
  late IStorageService credentialServiceMock;
  late IAuthService authServiceMock;
  late IBoardService boardServiceMock;
  late IStackService stackServiceMock;

  setUp(() {
    cardDetailsControllerMock =
        Get.put<CardDetailsController>(CardDetailsController());
  });

  testWidgets('show a simple card', (tester) async {
    var resp =
        Account('admin', 'password', 'authData', 'http://localhost', true);
    // when(credentialServiceMock.getAccount()).thenReturn(resp);
    // when(authServiceMock.isAuth()).thenReturn(true);

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
