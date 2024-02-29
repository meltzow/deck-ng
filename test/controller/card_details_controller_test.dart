import 'package:deck_ng/controller/card_details_controller.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/model/label.dart';
import 'package:deck_ng/model/stack.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:test/test.dart';

import 'board_details_controller_test.mocks.dart';

@GenerateMocks([ICardService])
void main() {
  test('select first available stack successfully', () async {
    IBoardService boardServiceMock =
        Get.put<IBoardService>(MockIBoardService());
    var cardServiceMock = Get.put<ICardService>(MockICardService());

    final controller = Get.put(CardDetailsController());

    var cardId = 2;
    var boardId = 1;
    var stackId = 3;

    var card = Card(title: 'foocard', id: cardId);
    var board = Board(title: 'foo', id: boardId);

    var stack = Stack(title: "offen", cards: [card], id: 1);
    var labels = [Label(title: 'first', id: 1), Label(title: 'second', id: 2)];

    controller.cardId = cardId;
    controller.boardId = boardId;
    controller.stackId = stackId;
    controller.cardData = card;

    Card resp1 = card..labels.add(labels.first);
    Card resp2 = card..labels.add(labels[1]);
    when(cardServiceMock.assignLabel2Card(boardId, stackId, cardId, 1))
        .thenAnswer((_) async {});
    when(cardServiceMock.assignLabel2Card(boardId, stackId, cardId, 2))
        .thenAnswer((_) async => resp2);

    controller.addLabels(
        labels.map((e) => ValueItem(label: e.title, value: e)).toList());

    expect(controller.cardData?.labels.length, labels.length);
  });

  tearDown(() {
    Get.delete<CardDetailsController>();
  });
}
