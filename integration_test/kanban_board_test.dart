import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/controller/kanban_board_controller.dart';
import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/screen/kanban_board_screen.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'kanban_board_test.mocks.dart';


@GenerateNiceMocks([
  MockSpec<IStorageService>(),
  MockSpec<IBoardService>(),
  MockSpec<IStackService>(),
  MockSpec<ICardService>(),
  MockSpec<INotificationService>(),
])
void main() {
  late IStorageService credentialServiceMock;

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    Get.testMode = true;
    Get.replace<IStorageService>(MockIStorageService());
    credentialServiceMock = Get.find<IStorageService>();
    Get.replace<IBoardService>(MockIBoardService());
    Get.replace<IStackService>(MockIStackService());
    Get.replace<ICardService>(MockICardService());
    Get.replace<INotificationService>(MockINotificationService());
    Get.lazyPut(()=>KanbanBoardController());

    var resp = [Board(title: 'garden', id: 1), Board(title: 'home', id: 2)]
        .map((e) => e.toJson())
        .toList();
     //when(httpServiceMock.getListResponse('/index.php/apps/deck/api/v1/boards'))
     //    .thenAnswer((_) async => resp);
  });

  testWidgets('display kanban board', (WidgetTester tester) async {
    when(credentialServiceMock.hasAccount()).thenReturn(true);
    when(credentialServiceMock.getAccount())
        .thenReturn(Account('foo', 'ddd', 'authData', 'url', true));



    await tester.pumpWidget(MyApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.kanbanBoard,
        initialPages: [
          GetPage(
            parameters: const {'boardId': '22'},
            name: AppRoutes.kanbanBoard,
            page: () => KanbanBoardScreen(),
          )
        ]));
    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await binding.takeScreenshot('test-screenshot');
    //FIXME
    // await screenshot(binding, tester, lo.localeName, 'board-overview',
    //     silent: false);
  });
}
