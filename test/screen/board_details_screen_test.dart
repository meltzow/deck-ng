// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:deck_ng/main.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/model/stack.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'board_details_screen_test.mocks.dart';

@GenerateMocks([IBoardService, IStackService])
void main() {
  late IBoardService boardServiceMock;
  late IStackService stackServiceMock;

  setUp(() {
    boardServiceMock = Get.put<IBoardService>(MockIBoardService());
    stackServiceMock = Get.put<IStackService>(MockIStackService());
  });

  testWidgets('display board details', (WidgetTester tester) async {
    var resp = Board(title: 'foo', id: 1);
    var stacks = [
      Stack(title: "todo", cards: [Card(title: "issue 1", id: 1)], id: 1),
      Stack(title: "in progress", cards: [Card(title: "issue 2", id: 2)], id: 2),
    ];
    when(boardServiceMock.getAllBoards()).thenAnswer((_) async => [resp]);
    when(boardServiceMock.getBoard(1)).thenAnswer((_) async => resp);
    when(stackServiceMock.getAll(1)).thenAnswer((_) async => stacks);
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      initialRoute: '/',
    ));

    Get.toNamed('/boards/details', arguments: {'boardId': 1});
    await tester.pumpAndSettle();

    expect(find.text('Boards details'), findsOneWidget);
    expect(find.text('foo'), findsNothing);

    await tester.pumpAndSettle();

    expect(find.text('in progress'), findsOneWidget);
    expect(find.text('todo'), findsOneWidget);
  });
}
