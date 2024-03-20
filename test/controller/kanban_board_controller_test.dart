import 'package:deck_ng/controller/kanban_board_controller.dart';
import 'package:deck_ng/model/models.dart' as NC;
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Inotification_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'kanban_board_controller_test.mocks.dart';

@GenerateMocks(
    [IBoardService, IStackService, ICardService, INotificationService])
void main() {
  var boardRepositoryImplMock = Get.put<IBoardService>(MockIBoardService());
  var stackServiceMock = Get.put<IStackService>(MockIStackService());
  var cardServiceMock = Get.put<ICardService>(MockICardService());
  var notifyServiceMock =
      Get.put<INotificationService>(MockINotificationService());
  setUp(() {
    Get.testMode = true;
  });

  test('reordering in same stack must save old card with new order', () async {
    final controller = Get.put(KanbanBoardController());

    controller.boardId = 1;
    expect(controller.boardId, 1);
    expect(controller.stackData, []);

    var board = NC.Board(title: 'foo', id: 1);
    var stack = NC.Stack(title: "offen", id: 17, boardId: board.id);
    var card1 = NC.Card(title: "issue1", id: 1, stackId: stack.id);
    var draggedCard = NC.Card(title: "issue2", id: 2, stackId: stack.id);
    stack.cards = [card1, draggedCard];
    var respStack = [stack];

    when(cardServiceMock.updateCard(
            board.id, stack.id, draggedCard.id, draggedCard))
        .thenAnswer((_) async => card1);
    when(notifyServiceMock.successMsg('Card', 'Card Updated Successfully'))
        .thenReturn(null);
    controller.stackData = respStack;

    controller.reorder(stack.id, 1, 0);

    verify(cardServiceMock.updateCard(
            board.id, stack.id, draggedCard.id, draggedCard))
        .called(1);

    // verify(notifyServiceMock.successMsg('Card', 'Card Updated Successfully'))
    //     .called(1);
  });

  test('reordering in different stack at first position', () async {
    final controller = Get.put(KanbanBoardController());

    controller.boardId = 1;
    expect(controller.boardId, 1);
    expect(controller.stackData, []);

    var oldCardIndex = 1;
    var newCardIndex = 0;

    var board = NC.Board(title: 'foo', id: 1);
    var draggedFromStack =
        NC.Stack(title: "backlog", id: 18, boardId: board.id);
    var draggedToStack =
        NC.Stack(title: "in progress", id: 20, boardId: board.id);
    var draggedCard =
        NC.Card(title: "issue1", id: 1, stackId: draggedFromStack.id);
    var card2 = NC.Card(title: "issue2", id: 2, stackId: draggedFromStack.id);
    var card3 = NC.Card(title: "issue2", id: 3, stackId: draggedToStack.id);
    draggedFromStack.cards = [card2, draggedCard];
    expect(draggedFromStack.cards[oldCardIndex].id, draggedCard.id);

    draggedToStack.cards = [card3];

    when(cardServiceMock.reorderCard(board.id, draggedFromStack.id,
            draggedCard.id, draggedCard, -1, draggedToStack.id))
        .thenAnswer((_) async => draggedCard);
    when(notifyServiceMock.successMsg('Card', 'Card Updated Successfully'))
        .thenReturn(null);
    controller.stackData = [draggedFromStack, draggedToStack];

    controller.cardReorderHandler(
        oldCardIndex, newCardIndex, draggedFromStack.id, draggedToStack.id);

    verify(cardServiceMock.reorderCard(board.id, draggedFromStack.id,
            draggedCard.id, draggedCard, -1, draggedToStack.id))
        .called(1);

    // verify(notifyServiceMock.successMsg('Card', 'Card Updated Successfully'))
    //     .called(1);
  });

  tearDown(() {
    Get.delete<KanbanBoardController>();
  });
}
