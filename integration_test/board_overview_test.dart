import 'package:deck_ng/main.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/impl/auth_repository_impl.dart';
import 'package:deck_ng/service/impl/board_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:screenshots/screenshots.dart';

import '../test/board_overview_screen_test.mocks.dart';

@GenerateMocks([IHttpService])
void main() {
  late IHttpService httpServiceMock;
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    Get.put<IAuthService>(AuthRepositoryImpl());
    httpServiceMock = Get.put<IHttpService>(MockIHttpService());
    Get.put<BoardRepositoryImpl>(BoardRepositoryImpl());

    var resp = [Board(title: 'garden', id: 1)].map((e) => e.toJson()).toList();
    when(httpServiceMock.getListResponse('/index.php/apps/deck/api/v1/boards'))
        .thenAnswer((_) async => resp);
  });

  testWidgets('display board overview', (WidgetTester tester) async {
    var lo = await getLocalizations(tester);
    await tester.pumpWidget(const MyApp());
    await Future.delayed(const Duration(seconds: 4), () {});
    await tester.pumpAndSettle();
    await screenshot(binding, tester, lo.localeName, 'board-overview',
        silent: false);
  });
}

Future<AppLocalizations> getLocalizations(WidgetTester t) async {
  late AppLocalizations result;
  await t.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            result = AppLocalizations.of(context)!;
            return Container();
          },
        ),
      ),
    ),
  );
  return result;
}
