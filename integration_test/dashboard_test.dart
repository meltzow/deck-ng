import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/dashboard/dashboard_controller.dart';
import 'package:deck_ng/dashboard/dashboard_screen.dart';
import 'package:deck_ng/model/models.dart' as nc;
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:screenshots/src/capture_screen.dart';

import 'dashboard_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<StorageService>(),
  MockSpec<BoardService>(),
  MockSpec<StackService>(),
  MockSpec<NotificationService>(),
])
void main() {
  late DashboardController controller;
  late StorageService storageServiceMock;
  late StackService stackServiceMock;
  late BoardService boardServiceMock;

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    Get.testMode = true;
    Get.replace<StorageService>(MockStorageService());
    storageServiceMock = Get.find<StorageService>();
    Get.replace<BoardService>(MockBoardService());
    boardServiceMock = Get.find<BoardService>();
    Get.replace<StackService>(MockStackService());
    stackServiceMock = Get.find<StackService>();
    controller = DashboardController();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('display dashboard', (WidgetTester tester) async {
    when(storageServiceMock.hasAccount()).thenReturn(true);
    when(storageServiceMock.getAccount()).thenReturn(nc.Account(
        username: 'foo',
        password: 'ddd',
        authData: 'authData',
        url: 'url',
        isAuthenticated: true));

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

    Get.lazyReplace<DashboardController>(() => controller);

    await tester.pumpWidget(MyApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        initialPages: [
          GetPage(
            name: AppRoutes.home,
            page: () => DashboardScreen(),
          )
        ]));
    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await screenshot(binding, tester, 'dashboard_screen');
  });

  testWidgets('display error when fetching boards fails',
      (WidgetTester tester) async {
    when(storageServiceMock.hasAccount()).thenReturn(true);
    when(storageServiceMock.getAccount()).thenReturn(nc.Account(
        username: 'foo',
        password: 'ddd',
        authData: 'authData',
        url: 'url',
        isAuthenticated: true));

    // Simulate a failed HTTP request
    when(boardServiceMock.getAllBoards())
        .thenThrow(Exception('Failed to fetch boards'));

    Get.lazyReplace<DashboardController>(() => controller);

    await tester.pumpWidget(MyApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        initialPages: [
          GetPage(
            name: AppRoutes.home,
            page: () => DashboardScreen(),
          )
        ]));
    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await screenshot(binding, tester, 'dashboard_screen_error');

    // Verify that the error state is displayed
    expect(find.text('Failed to fetch data: Exception: Failed to fetch boards'),
        findsOneWidget);
  });

  testWidgets('display error when board data is invalid',
      (WidgetTester tester) async {
    when(storageServiceMock.hasAccount()).thenReturn(true);
    when(storageServiceMock.getAccount()).thenReturn(nc.Account(
        username: 'foo',
        password: 'ddd',
        authData: 'authData',
        url: 'url',
        isAuthenticated: true));

    // Simulate a successful HTTP request with invalid board data
    var invalidBoard =
        nc.Board(title: '', id: 1); // Title is mandatory but empty
    var resp = [invalidBoard];
    when(boardServiceMock.getAllBoards()).thenAnswer((_) async => resp);
    List<nc.Stack> stacksForBoard1 = [];

    when(stackServiceMock.getAll(invalidBoard.id))
        .thenAnswer((_) async => stacksForBoard1);

    Get.lazyReplace<DashboardController>(() => controller);

    await tester.pumpWidget(MyApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        initialPages: [
          GetPage(
            name: AppRoutes.home,
            page: () => DashboardScreen(),
          ),
        ]));

    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await screenshot(binding, tester, 'dashboard_screen_invalid_data');

    // Verify that the error state is displayed
    expect(
        find.text('Failed to fetch data: Invalid board data'), findsOneWidget);
  });
}
