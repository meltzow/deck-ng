// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:deck_ng/controller/board_details_controller.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/my_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  BoardDetailsController,
])
void main() {
  late BoardDetailsController controllerMock;

  setUp(() {
    controllerMock = Get.put<BoardDetailsController>(BoardDetailsController());
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    var resp = [Board(title: 'foo', id: 1)];
    // when(boardServiceMock.getAllBoards()).thenAnswer((_) async => resp);
    // when(authServiceMock.isAuth()).thenReturn(true);
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      initialRoute: '/boards/details',
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
