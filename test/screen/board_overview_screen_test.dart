// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'board_overview_screen_test.mocks.dart';

@GenerateMocks([IBoardService, IAuthService, IStackService])
void main() {
  late IBoardService boardServiceMock;
  late IAuthService authServiceMock;
  late IStackService stackServiceMock;

  setUp(() {
    boardServiceMock = Get.put<IBoardService>(MockIBoardService());
    authServiceMock = Get.put<IAuthService>(MockIAuthService());
    stackServiceMock = Get.put<IStackService>(MockIStackService());
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    var resp = [Board(title: 'foo', id: 1)];
    when(boardServiceMock.getAllBoards()).thenAnswer((_) async => resp);
    when(authServiceMock.isAuth()).thenReturn(true);
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      initialRoute: '/boards',
    ));

    // Verify that our counter starts at 0.
    expect(find.text('Boards'), findsOneWidget);
    expect(find.text('foo'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that our counter has incremented.
    expect(find.text('Boards'), findsOneWidget);
    expect(find.text('foo'), findsOneWidget);
  });
}
