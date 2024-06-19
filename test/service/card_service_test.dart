import 'dart:convert';

import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/model/label.dart';
import 'package:deck_ng/service/impl/card_service_impl.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'board_service_test.mocks.dart';
import 'fake_provider.dart';

@GenerateMocks([HttpService])
void main() {
  group('cardGroup', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      PathProviderPlatform.instance = FakePathProviderPlatform();
    });

    test('add label to card successfully', () async {
      final httpServiceMock = Get.put<HttpService>(MockHttpService());
      final CardService cardService = Get.put<CardService>(CardServiceImpl());

      var boardId = 1;
      var stackId = 1;
      var cardId = 1;
      var labelId = 1;
      var label = Label(title: 'wip', id: labelId);
      var mockResp = (Card(title: 'foo', id: cardId, stackId: stackId)
            ..labels = [label])
          .toJson();

      when(httpServiceMock.put(
          "/index.php/apps/deck/api/v1/boards/$boardId/stacks/$stackId/cards/$cardId/assignLabel",
          json.encode({"labelId": labelId}))).thenAnswer((_) async => mockResp);

      var cardResp =
          await cardService.assignLabel2Card(boardId, stackId, cardId, labelId);
      // expect(cardResp.id, cardId);
      // expect(cardResp.labels.length, 1);
      // expect(cardResp.labels.first.id, labelId);
    });
  });
}
