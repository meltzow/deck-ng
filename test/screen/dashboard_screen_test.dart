import 'package:deck_ng/controller/dashboard_controller.dart';
import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/screen/dashboard_screen.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'kanban_board_screen_test.mocks.dart';
import 'test_helpers.dart';

@GenerateMocks([
  DashboardController,
  BoardService,
  NotificationService,
  StackService,
  AuthService,
  StorageService
])
void main() {
  late var controllerMock;
  late BoardService boardServiceMock;
  late AuthService authServiceMock;
  late StorageService storageServiceMock;
  late StackService stackServiceMock;

  setUp(() {
    Get.testMode = true;
    authServiceMock = Get.put<AuthService>(MockAuthService());
    storageServiceMock = Get.put<StorageService>(MockStorageService());
    boardServiceMock = Get.put<BoardService>(MockBoardService());
    stackServiceMock = Get.put<StackService>(MockStackService());
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('touchable links to boards are correct',
      (WidgetTester tester) async {
    var board1 = Board(title: 'foo1', id: 1);
    var board2 = Board(title: 'foo2', id: 2);
    var resp = [board1, board2];

    setupMockAccount(storageServiceMock, authServiceMock);

    when(boardServiceMock.getAllBoards())
        .thenAnswer((realInvocation) => (Future.value(resp)));

    when(stackServiceMock.getAll(board1.id)).thenAnswer((_) => Future.value(
        [Stack(title: 'todo', boardId: board1.id, id: 1, cards: [])]));
    when(stackServiceMock.getAll(board2.id)).thenAnswer((_) => Future.value(
        [Stack(title: 'todo2', boardId: board2.id, id: 1, cards: [])]));

    controllerMock = Get.put<DashboardController>(DashboardController());
    await tester.pumpWidget(GetMaterialApp(
      home: DashboardScreen(),
      getPages: [
        GetPage(
          name: '/boards/details',
          page: () => DashboardScreen(),
        ),
      ],
    ));

    // Verify that our counter starts at 0.
    expect(find.text('Dashboard'), findsOneWidget);
    await tester.pumpAndSettle();
    //find first board
    expect(find.text('foo1'), findsOneWidget);
    //find second board
    expect(find.text('foo2'), findsOneWidget);

    await tester.tap(find.text('foo2'));
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/boards/details?boardId=2');

    await tester.tap(find.text('foo1'));
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/boards/details?boardId=1');
  });
}
