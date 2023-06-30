import 'package:deck_ng/main.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:screenshots/screenshots.dart';

import '../test/service/board_service_test.mocks.dart';
import 'Localization.dart';

@GenerateMocks([IHttpService])
void main() {
  late IHttpService httpServiceMock;
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await initServices();
    Get.replace<IHttpService>(MockIHttpService());
    httpServiceMock = Get.find<IHttpService>();

    var resp = [Board(title: 'garden', id: 1)].map((e) => e.toJson()).toList();
    when(httpServiceMock.getListResponse('/index.php/apps/deck/api/v1/boards'))
        .thenAnswer((_) async => resp);
  });

  testWidgets('display board overview', (WidgetTester tester) async {
    var lo = await Localization.getLocalizations(tester);
    await tester.pumpWidget(MyApp(debugShowCheckedModeBanner: false));
    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();
    await screenshot(binding, tester, lo.localeName, 'login', silent: false);
  });
}
