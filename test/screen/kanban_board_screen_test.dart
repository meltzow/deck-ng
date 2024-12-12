import 'package:deck_ng/board/kanban_board_controller.dart';
import 'package:deck_ng/board/kanban_board_screen.dart';
import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'kanban_board_screen_test.mocks.dart';
import 'test_helpers.dart';

@GenerateMocks([
  KanbanBoardController,
  BoardService,
  NotificationService,
  StackService,
  CardService,
  AuthService,
  StorageService
])
void main() {
  late KanbanBoardController controllerMock;
  late BoardService boardServiceMock;
  late AuthService authServiceMock;
  late StorageService storageServiceMock;
  late NotificationService notificationServiceMock;
  late StackService stackServiceMock;

  setUp(() {
    Get.testMode = true;
    boardServiceMock = Get.put<BoardService>(MockBoardService());
    authServiceMock = Get.put<AuthService>(MockAuthService());
    stackServiceMock = Get.put<StackService>(MockStackService());
    Get.put<CardService>(MockCardService());
    Get.put<NotificationService>(MockNotificationService());
    storageServiceMock = Get.put<StorageService>(MockStorageService());
    Get.parameters = <String, String>{'boardId': '1'};
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    var resp = [Board(title: 'foo', id: 1)];

    setupMockAccount(storageServiceMock, authServiceMock);

    when(boardServiceMock.getBoard(1)).thenAnswer(
        (realInvocation) => (Future.value(Board(title: 'garden', id: 1))));

    when(stackServiceMock.getAll(1)).thenAnswer((_) =>
        Future.value([Stack(title: 'todo', boardId: 1, id: 1, cards: [])]));

    controllerMock = Get.put<KanbanBoardController>(KanbanBoardController());
    await tester.pumpWidget(GetMaterialApp(home: KanbanBoardScreen()));

    // Verify that our counter starts at 0.
    expect(find.text('Board'), findsOneWidget);
    // expect(find.text('foo'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // // await tester.tap(find.byIcon(Icons.add));
    // await tester.pumpAndSettle();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('Boards'), findsOneWidget);
    // expect(find.text('foo'), findsOneWidget);
  });
}
