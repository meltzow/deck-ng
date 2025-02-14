import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/card_details/card_details_controller.dart';
import 'package:deck_ng/card_details/card_details_screen.dart';
import 'package:deck_ng/model/models.dart' as nc;
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:screenshots/src/capture_screen.dart';

import 'card_details_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<StorageService>(),
  MockSpec<BoardService>(),
  MockSpec<CardService>(),
  MockSpec<NotificationService>(),
])
void main() {
  late CardDetailsController controller;
  late StorageService storageServiceMock;
  late BoardService boardServiceMock;
  late CardService cardServiceMock;

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    Get.testMode = true;
    Get.replace<StorageService>(MockStorageService());
    storageServiceMock = Get.find<StorageService>();
    Get.replace<BoardService>(MockBoardService());
    boardServiceMock = Get.find<BoardService>();
    Get.replace<CardService>(MockCardService());
    cardServiceMock = Get.find<CardService>();
    Get.replace<NotificationService>(MockNotificationService());

    controller = CardDetailsController();
  });

  testWidgets('display card details', (WidgetTester tester) async {
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
    var card1 = nc.Card(title: 'seeding carrots', id: 1, stackId: stack1.id);
    stack1.cards = [card1];
    var stacksForBoard1 = [stack1];

    when(boardServiceMock.getBoard(board1.id)).thenAnswer((_) async => board1);
    when(cardServiceMock.getCard(board1.id, stack1.id, card1.id!))
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
}
