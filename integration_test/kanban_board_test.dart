import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/controller/kanban_board_controller.dart';
import 'package:deck_ng/model/models.dart' as nc;
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/screen/kanban_board_screen.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:screenshots/src/capture_screen.dart';

import 'kanban_board_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IStorageService>(),
  MockSpec<IBoardService>(),
  MockSpec<IStackService>(),
  MockSpec<ICardService>(),
  MockSpec<INotificationService>(),
])
void main() {
  late KanbanBoardController controller;
  late IStorageService credentialServiceMock;
  late IStackService stackServiceMock;
  late IBoardService boardServiceMock;

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    Get.testMode = true;
    Get.replace<IStorageService>(MockIStorageService());
    credentialServiceMock = Get.find<IStorageService>();
    Get.replace<IBoardService>(MockIBoardService());
    boardServiceMock = Get.find<IBoardService>();
    Get.replace<IStackService>(MockIStackService());
    Get.replace<ICardService>(MockICardService());
    stackServiceMock = Get.find<IStackService>();
    Get.replace<INotificationService>(MockINotificationService());
    controller = KanbanBoardController();
  });

  testWidgets('display kanban board', (WidgetTester tester) async {
    when(credentialServiceMock.hasAccount()).thenReturn(true);
    when(credentialServiceMock.getAccount())
        .thenReturn(nc.Account('foo', 'ddd', 'authData', 'url', true));

    var board1 = nc.Board(title: 'garden', id: 1);
    var resp = [board1];
    when(boardServiceMock.getAllBoards()).thenAnswer((_) async => resp);

    var stack1 = nc.Stack(title: 'todo', boardId: board1.id, id: 1);
    stack1.cards = [
      nc.Card(title: 'seeding carrots', id: 1, stackId: stack1.id),
      nc.Card(title: 'harvesting apples', id: 2, stackId: stack1.id),
    ];
    var stack2 = nc.Stack(title: 'in preparation', boardId: board1.id, id: 2);
    stack2.cards = [
      nc.Card(title: 'automatic watering', id: 3, stackId: stack2.id),
    ];
    var stack3 = nc.Stack(title: 'in progress', boardId: board1.id, id: 3);
    stack3.cards = [
      nc.Card(title: 'cut the lawn', id: 4, stackId: stack3.id),
      nc.Card(title: 'buy a spade', id: 5, stackId: stack3.id),
    ];
    var stacksForBoard1 = [stack1, stack2, stack3];

    when(stackServiceMock.getAll(board1.id))
        .thenAnswer((_) async => stacksForBoard1);

    Get.lazyReplace<KanbanBoardController>(() => controller);

    await tester.pumpWidget(MyApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.kanbanBoard,
        initialPages: [
          GetPage(
            parameters: {'boardId': board1.id.toString()},
            name: AppRoutes.kanbanBoard,
            page: () => KanbanBoardScreen(),
          )
        ]));
    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await screenshot(binding, tester, 'kanban_board_screen');
  });
}
