import 'package:deck_ng/controller/board_details_controller.dart';
import 'package:deck_ng/model/models.dart' as NC;
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Inotification_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'board_details_controller_test.mocks.dart';

@GenerateMocks(
    [IBoardService, IStackService, ICardService, INotificationService])
void main() {
  test('reordering in same stack must save old card with new order', () async {
    IBoardService boardRepositoryImplMock =
        Get.put<IBoardService>(MockIBoardService());
    var stackServiceMock = Get.put<IStackService>(MockIStackService());
    var cardServiceMock = Get.put<ICardService>(MockICardService());
    var notifyServiceMock =
        Get.put<INotificationService>(MockINotificationService());

    final controller = Get.put(BoardDetailsController());

    controller.boardId = 1;
    expect(controller.boardId, 1);
    expect(controller.stackData, []);

    var board = NC.Board(title: 'foo', id: 1);
    var stack = NC.Stack(title: "offen", id: 1, boardId: board.id);
    var card1 = NC.Card(title: "issue1", id: 1, stackId: 1);
    var card2 = NC.Card(title: "issue2", id: 2, stackId: 1);
    stack.cards = [card1, card2];
    var respStack = [stack];

    when(cardServiceMock.updateCard(board.id, stack.id, card1.id, card1))
        .thenAnswer((_) async => card1);
    when(notifyServiceMock.successMsg('Card', 'Card Updated Successfully'))
        .thenReturn(null);
    controller.stackData = respStack;

    controller.reorder(0, 0, 1);

    // expect(controller.selectedStackData, stack);
    // expect(controller.selectedStackId, 1);
  });

  test('reordering in different stack at first position', () async {
    IBoardService boardRepositoryImplMock =
        Get.put<IBoardService>(MockIBoardService());
    var stackServiceMock = Get.put<IStackService>(MockIStackService());
    var cardServiceMock = Get.put<ICardService>(MockICardService());
    var notifyServiceMock =
        Get.put<INotificationService>(MockINotificationService());

    final controller = Get.put(BoardDetailsController());

    controller.boardId = 1;
    expect(controller.boardId, 1);
    expect(controller.stackData, []);

    var oldCardIndex = 1;
    var newCardIndex = 0;
    var oldListIndex = 0;
    var newListIndex = 1;

    var board = NC.Board(title: 'foo', id: 1);
    var stack1 = NC.Stack(title: "backlog", id: 1, boardId: board.id);
    var stack2 = NC.Stack(title: "in progress", id: 2, boardId: board.id);
    var card1 = NC.Card(title: "issue1", id: 1, stackId: stack1.id);
    var card2 = NC.Card(title: "issue2", id: 2, stackId: stack1.id);
    var card3 = NC.Card(title: "issue2", id: 3, stackId: stack2.id);
    stack1.cards = [card1, card2];
    stack2.cards = [card3];

    // when(cardServiceMock.updateCard(board.id, stack.id, card1.id, card1))
    //     .thenAnswer((_) async => card1);
    when(notifyServiceMock.successMsg('Card', 'Card Updated Successfully'))
        .thenReturn(null);
    controller.stackData = [stack1, stack2];

    controller.cardReorderHandler(
        oldCardIndex, newCardIndex, oldListIndex, newListIndex);

    // expect(controller.selectedStackData, stack);
    // expect(controller.selectedStackId, 1);
  });

  tearDown(() {
    Get.delete<BoardDetailsController>();
  });
}
