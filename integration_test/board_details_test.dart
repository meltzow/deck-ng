import 'package:deck_ng/main.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/model/stack.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/impl/auth_repository_impl.dart';
import 'package:deck_ng/service/impl/board_repository_impl.dart';
import 'package:deck_ng/service/impl/stack_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:screenshots/screenshots.dart';

import '../test/board_service_test.mocks.dart';

@GenerateMocks([IHttpService])
void main() {
  late IHttpService httpServiceMock;
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    Get.put<IAuthService>(AuthRepositoryImpl());
    httpServiceMock = Get.put<IHttpService>(MockIHttpService());
    Get.put<IBoardService>(BoardRepositoryImpl());
    Get.put<StackRepositoryImpl>(StackRepositoryImpl());

    var resp = Board(title: 'garden', id: 1).toJson();
    when(httpServiceMock.getResponse('/index.php/apps/deck/api/v1/boards/1'))
        .thenAnswer((_) async => resp);

    var respList =
        [Board(title: 'garden', id: 1)].map((e) => e.toJson()).toList();
    when(httpServiceMock.getListResponse('/index.php/apps/deck/api/v1/boards'))
        .thenAnswer((_) async => respList);

    var stackList = [
      Stack(title: 'todo', id: 1, cards: []),
      Stack(title: 'in progress', id: 2, cards: [])
    ].map((e) => e.toJson()).toList();
    when(httpServiceMock
            .getListResponse('/index.php/apps/deck/api/v1/boards/1/stacks'))
        .thenAnswer((_) async => stackList);
  });

  testWidgets('display board details', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    Get.toNamed('/boards/details', arguments: {'boardId': 1});
    await tester.pumpAndSettle();

    await screenshot(binding, tester, 'en-US', 'myscreenshot1', silent: false);
  });
}
