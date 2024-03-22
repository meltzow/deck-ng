import 'dart:convert';

import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/controller/card_details_controller.dart';
import 'package:deck_ng/controller/dashboard_controller.dart';
import 'package:deck_ng/controller/kanban_board_controller.dart';
import 'package:deck_ng/controller/login_controller.dart';
import 'package:deck_ng/controller/settings_controller.dart';
import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/model/models.dart' as nc;
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/screen/card_details_screen.dart';
import 'package:deck_ng/screen/dashboard_screen.dart';
import 'package:deck_ng/screen/kanban_board_screen.dart';
import 'package:deck_ng/screen/login_screen.dart';
import 'package:deck_ng/screen/settings_screen.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:screenshots/src/capture_screen.dart';

import 'screenshots_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IStorageService>(),
  MockSpec<IBoardService>(),
  MockSpec<IStackService>(),
  MockSpec<ICardService>(),
  MockSpec<INotificationService>(),
  MockSpec<IAuthService>(),
])
void main() {
  late IStorageService storageServiceMock;
  late IBoardService boardServiceMock;
  late IStackService stackServiceMock;
  late ICardService cardServiceMock;
  late IAuthService authServiceMock;

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    Get.testMode = true;
    Get.replace<IStorageService>(MockIStorageService());
    storageServiceMock = Get.find<IStorageService>();
    Get.replace<IBoardService>(MockIBoardService());
    boardServiceMock = Get.find<IBoardService>();
    Get.replace<ICardService>(MockICardService());
    cardServiceMock = Get.find<ICardService>();
    Get.replace<IStackService>(MockIStackService());
    stackServiceMock = Get.find<IStackService>();
    Get.replace<IAuthService>(MockIAuthService());
    authServiceMock = Get.find<IAuthService>();

    Get.replace<INotificationService>(MockINotificationService());
  });

  tearDown(() {
    resetMockitoState();
    reset(authServiceMock);
  });

  testWidgets('display card details', (WidgetTester tester) async {
    late CardDetailsController controller = CardDetailsController();
    when(storageServiceMock.hasAccount()).thenReturn(true);
    when(storageServiceMock.getAccount())
        .thenReturn(nc.Account('foo', 'ddd', 'authData', 'url', true));

    var board1 = nc.Board(title: 'garden', id: 1);
    var resp = [board1];
    when(boardServiceMock.getAllBoards()).thenAnswer((_) async => resp);

    var stack1 = nc.Stack(title: 'todo', boardId: board1.id, id: 1);
    var card1 = nc.Card(title: 'seeding carrots', id: 1, stackId: stack1.id);
    stack1.cards = [card1];
    var stacksForBoard1 = [stack1];

    when(boardServiceMock.getBoard(board1.id)).thenAnswer((_) async => board1);
    when(cardServiceMock.getCard(board1.id, stack1.id, card1.id))
        .thenAnswer((_) async => card1);

    Get.lazyReplace<CardDetailsController>(() => controller);

    await tester.pumpWidget(MyApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.cardDetails,
        initialPages: [
          GetPage(
            parameters: {
              'cardId': '${card1.id}',
              'boardId': '${board1.id}',
              'stackId': '${stack1.id}'
            },
            name: AppRoutes.cardDetails,
            page: () => CardDetailsScreen(),
          )
        ]));
    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await screenshot(binding, tester, 'card_details_screen');
  });

  testWidgets('display dashboard', (WidgetTester tester) async {
    late DashboardController controller = DashboardController();
    when(storageServiceMock.hasAccount()).thenReturn(true);
    when(storageServiceMock.getAccount())
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

  testWidgets('display kanban board', (WidgetTester tester) async {
    late KanbanBoardController controller = KanbanBoardController();
    when(storageServiceMock.hasAccount()).thenReturn(true);
    when(storageServiceMock.getAccount())
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

  testWidgets('display login screen', (tester) async {
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

    var resp = Capabilities(CapabilitiesOcs(
        meta: Meta('success', 200, 'success'),
        data: CapabilitiesData(Version(0, 0, 26, "26.0.0", '', false), {})));
    when(authServiceMock.checkServer('https://my.next.cloud'))
        .thenAnswer((_) async => resp);
    when(authServiceMock.isAuth()).thenReturn(false);

    final controller = LoginController();
    Get.lazyReplace<LoginController>(() => controller);

    await tester.pumpWidget(MyApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.login,
        initialPages: [
          GetPage(
            name: AppRoutes.login,
            page: () => LoginScreen(),
          )
        ]));

    await tester.enterText(
        find.byKey(const Key('serverUrl')), 'https://my.next.cloud');
    await tester.enterText(find.byKey(const Key('username')), 'deckNG');
    await tester.enterText(find.byKey(const Key('password')), 'secret');
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    await screenshot(binding, tester, 'login_screen');
  });

  testWidgets('display settings screen', (WidgetTester tester) async {
    when(storageServiceMock.hasAccount()).thenReturn(true);
    when(storageServiceMock.getAccount())
        .thenReturn(nc.Account('foo', 'ddd', 'authData', 'url', true));

    when(storageServiceMock.hasSettings()).thenReturn(true);
    when(storageServiceMock.getSetting()).thenReturn(nc.Setting('english'));

    final controller = SettingsController();
    Get.lazyReplace<SettingsController>(() => controller);

    await tester.pumpWidget(MyApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.settings,
        initialPages: [
          GetPage(
            parameters: {},
            name: AppRoutes.settings,
            page: () => SettingScreen(),
          )
        ]));
    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await screenshot(binding, tester, 'settings_screen');
  });
}
