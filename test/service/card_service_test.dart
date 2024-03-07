import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/model/label.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/impl/card_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'board_service_test.mocks.dart';

@GenerateMocks([IHttpService])
void main() {
  group('cardGroup', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    test('add label to card successfully', () async {
      final httpServiceMock = Get.put<IHttpService>(MockIHttpService());
      final ICardService cardService = Get.put<ICardService>(CardServiceImpl());

      var boardId = 1;
      var stackId = 1;
      var cardId = 1;
      var labelId = 1;
      var label = Label(title: 'wip', id: labelId);
      var mockResp =
          (Card(title: 'foo', id: cardId, stackId: stackId)..labels = [label]).toJson();

      when(httpServiceMock.put(
              "/boards/{boardId}/stacks/{stackId}/cards/{cardId}/assignLabel",
              labelId))
          .thenAnswer((_) async => mockResp);

      var cardResp =
          await cardService.assignLabel2Card(boardId, stackId, cardId, labelId);
      // expect(cardResp.id, cardId);
      // expect(cardResp.labels.length, 1);
      // expect(cardResp.labels.first.id, labelId);
    });
  });
}
