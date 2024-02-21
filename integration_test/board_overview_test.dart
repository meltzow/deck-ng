import 'package:deck_ng/env.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/my_app.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './Localization.dart';
import 'board_overview_test.mocks.dart';

@GenerateMocks([IHttpService, IStorageService])
void main() {
  late IHttpService httpServiceMock;
  late IStorageService credentialServiceMock;

  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    Environment.init();
    Get.replace<IStorageService>(MockIStorageService());
    credentialServiceMock = Get.find<IStorageService>();

    Get.replace<IHttpService>(MockIHttpService());
    httpServiceMock = Get.find<IHttpService>();

    var resp = [Board(title: 'garden', id: 1), Board(title: 'home', id: 2)]
        .map((e) => e.toJson())
        .toList();
    when(httpServiceMock.getListResponse('/index.php/apps/deck/api/v1/boards'))
        .thenAnswer((_) async => resp);
  });

  testWidgets('display board overview', (WidgetTester tester) async {
    var lo = await Localization.getLocalizations(tester);
    await tester.pumpWidget(MyApp(debugShowCheckedModeBanner: false));
    Get.toNamed('/boards');
    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();
    //FIXME
    // await screenshot(binding, tester, lo.localeName, 'board-overview',
    //     silent: false);
  });
}
