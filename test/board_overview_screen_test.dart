// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:deck_ng/main.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/board_repository_impl.dart';
import 'package:deck_ng/service/impl/auth_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'board_overview_screen_test.mocks.dart';

@GenerateMocks([IHttpService])
void main() {
  late IHttpService httpServiceMock;

  setUp(() {
    Get.put<IAuthService>(AuthRepositoryImpl());
    httpServiceMock = Get.put<IHttpService>(MockIHttpService());
    Get.put<BoardRepositoryImpl>(BoardRepositoryImpl());
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    var resp = [Board(title: 'foo', id: 1)].map((e) => e.toJson()).toList();
    when(httpServiceMock.getListResponse('/index.php/apps/deck/api/v1/boards'))
        .thenAnswer((_) async => resp);
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Clicks: 0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('Clicks: 1'), findsOneWidget);
  });
}
