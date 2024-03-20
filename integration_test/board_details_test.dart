import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/model/stack.dart';
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test/service/board_service_test.mocks.dart';

@GenerateMocks([IHttpService])
void main() {
  late IHttpService httpServiceMock;
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    Get.replace<IHttpService>(MockIHttpService());
    httpServiceMock = Get.find<IHttpService>();

    var resp = Board(title: 'garden', id: 1).toJson();
    when(httpServiceMock.get('/index.php/apps/deck/api/v1/boards/1'))
        .thenAnswer((_) async => resp);

    var stackList = [
      Stack(
          title: 'todo',
          id: 1,
          cards: [
            Card(title: 'issue 1', id: 1, stackId: 1),
            Card(title: 'issue 2', id: 1, stackId: 1)
          ],
          boardId: 1),
      Stack(title: 'in progress', id: 2, cards: [], boardId: 1)
    ].map((e) => e.toJson()).toList();
    when(httpServiceMock
            .getListResponse('/index.php/apps/deck/api/v1/boards/1/stacks'))
        .thenAnswer((_) async => stackList);
  });

  testWidgets('display board details', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(debugShowCheckedModeBanner: false));
    Get.toNamed('/boards/details', arguments: {'boardId': 1});
    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();

    //FIXME
    // await screenshot(binding, tester, lo.localeName, 'board-details',
    //     silent: false);
  });
}
