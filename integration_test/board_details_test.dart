import 'dart:io';

import 'package:deck_ng/main.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/screen/board_details_screen.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/auth_repository_impl.dart';
import 'package:deck_ng/service/board_repository_impl.dart';
import 'package:deck_ng/service/stack_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test/widget_test.mocks.dart';

@GenerateMocks([IHttpService])
void main() {
  late IHttpService httpServiceMock;
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding();

  setUp(() {
    Get.put<IAuthService>(AuthRepositoryImpl());
    httpServiceMock = Get.put<IHttpService>(MockIHttpService());
    Get.put<BoardRepositoryImpl>(BoardRepositoryImpl());
    Get.put<StackRepositoryImpl>(StackRepositoryImpl());

    var resp = Board(title: 'garden', id: 1).toJson();
    when(httpServiceMock.getResponse('/index.php/apps/deck/api/v1/boards/1'))
        .thenAnswer((_) async => resp);

    var respList =
        [Board(title: 'garden', id: 1)].map((e) => e.toJson()).toList();
    when(httpServiceMock.getListResponse('/index.php/apps/deck/api/v1/boards'))
        .thenAnswer((_) async => respList);
  });

  testWidgets('display board details', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    Get.to(BoardDetailsScreen());
    await tester.pumpAndSettle();
    String platformName = '';

    if (!kIsWeb) {
      // Not required for the web. This is required prior to taking the screenshot.
      await binding.convertFlutterSurfaceToImage();

      if (Platform.isAndroid) {
        platformName = "android";
      } else {
        platformName = "ios";
      }
    } else {
      platformName = "web";
    }

    // await binding.convertFlutterSurfaceToImage();
    // To make sure at least one frame has rendered
    await tester.pumpAndSettle();
    // Take the screenshot
    await binding.takeScreenshot('board-details-$platformName');
  });
}
