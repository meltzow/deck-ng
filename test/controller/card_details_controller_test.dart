import 'package:deck_ng/controller/card_details_controller.dart';
import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/services.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'card_details_controller_test.mocks.dart';

@GenerateMocks([CardService, NotificationService, BoardService])
void main() {
  late CardDetailsController controller;
  late CardService cardServiceMock;
  late NotificationService notifyServiceMock;
  late BoardService boardServiceMock;

  setUp(() {
    Get.testMode = true;
    boardServiceMock = Get.put<BoardService>(MockBoardService());
    cardServiceMock = Get.put<CardService>(MockCardService());
    notifyServiceMock = Get.put<NotificationService>(MockNotificationService());

    controller = Get.put(CardDetailsController());
  });

  tearDown(() {
    Get.reset();
  });

  test('add a label to a card successfully', () async {
    var cardId = 2;
    var boardId = 1;
    var stackId = 3;

    var board = Board(title: 'foo', id: boardId);
    var card = Card(title: 'foocard', id: cardId, stackId: stackId);
    var stack = Stack(title: "offen", cards: [card], id: 1, boardId: boardId);

    var labels = [Label(title: 'first', id: 1), Label(title: 'second', id: 2)];

    controller.cardId = RxInt(cardId);
    controller.boardId = RxInt(boardId);
    controller.stackId = RxInt(stackId);
    controller.card = Rxn<Card>(card);

    Card resp2 = card;
    card.labels = [labels[1]];
    when(cardServiceMock.assignLabel2Card(boardId, stackId, cardId, 1))
        .thenAnswer((_) async {});
    when(cardServiceMock.assignLabel2Card(boardId, stackId, cardId, 2))
        .thenAnswer((_) async => resp2);

    controller.addLabel(labels.first);

    expect(controller.card.value?.labels.length, labels.length);
  });

  test('save a card successfully', () async {
    var cardId = 2;
    var boardId = 1;
    var stackId = 3;

    var board = Board(title: 'foo', id: boardId);
    var card = Card(title: 'foocard', id: cardId, stackId: stackId);
    var stack = Stack(title: "offen", cards: [card], id: 1, boardId: boardId);

    var labels = [Label(title: 'first', id: 1), Label(title: 'second', id: 2)];

    controller.cardId = RxInt(cardId);
    controller.boardId = RxInt(boardId);
    controller.stackId = RxInt(stackId);
    controller.card = Rxn<Card>(card);

    Card resp2 = card;

    when(notifyServiceMock.successMsg('Card', 'Card updated successfully'))
        .thenReturn(null);
    when(cardServiceMock.updateCard(boardId, stackId, cardId, card))
        .thenAnswer((_) async => resp2);

    await controller.updateCard(card);

    verify(notifyServiceMock.successMsg('Card', 'Card updated successfully'));
  });

  tearDown(() {
    Get.delete<CardDetailsController>();
  });
}
