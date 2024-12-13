import 'package:deck_ng/board_details/kanban_board_controller.dart';
import 'package:deck_ng/model/models.dart' as NC;
import 'package:deck_ng/service/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:test/test.dart';

import 'kanban_board_controller_test.mocks.dart';

@GenerateMocks([BoardService, StackService, CardService, NotificationService])
void main() {
  late BoardService boardServiceMock;
  late StackService stackServiceMock;
  late CardService cardServiceMock;
  late NotificationService notifyServiceMock;

  // Set up demangleStackTrace for non-standard stack traces
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is Chain) {
      return stack.toTrace();
    }
    return stack;
  };

  setUp(() {
    Get.testMode = true;
    boardServiceMock = Get.put<BoardService>(MockBoardService());
    stackServiceMock = Get.put<StackService>(MockStackService());
    cardServiceMock = Get.put<CardService>(MockCardService());
    notifyServiceMock = Get.put<NotificationService>(MockNotificationService());
  });

  tearDown(() {
    Get.reset();
  });

  test('reordering in same stack must save old card with new order', () async {
    Get.parameters = <String, String>{'boardId': '1'};
    var board = NC.Board(title: 'foo', id: 1);
    when(boardServiceMock.getBoard(board.id)).thenAnswer((_) async {
      return board;
    });
    when(stackServiceMock.getAll(board.id)).thenAnswer((_) async {
      return [];
    });

    final controller = Get.put(KanbanBoardController());

    controller.boardId = 1;
    expect(controller.boardId, 1);
    expect(controller.stackData, []);

    var stack = NC.Stack(title: "offen", id: 17, boardId: board.id);
    var card1 = NC.Card(title: "issue1", id: 1, stackId: stack.id);
    var draggedCard = NC.Card(title: "issue2", id: 2, stackId: stack.id);
    stack.cards = [card1, draggedCard];
    var respStack = [stack];

    when(cardServiceMock.updateCard(
            board.id, stack.id, draggedCard.id!, draggedCard))
        .thenAnswer((_) async => card1);
    when(notifyServiceMock.successMsg('Card', 'Card Updated Successfully'))
        .thenReturn(null);
    controller.stackData = respStack;

    controller.reorder(stack.id, 1, 0);

    verify(cardServiceMock.updateCard(
            board.id, stack.id, draggedCard.id!, draggedCard))
        .called(1);

    // verify(notifyServiceMock.successMsg('Card', 'Card Updated Successfully'))
    //     .called(1);
  });

  test('reordering in different stack at first position', () async {
    var board = NC.Board(title: 'foo', id: 1);
    when(boardServiceMock.getBoard(board.id)).thenAnswer((_) async {
      return board;
    });
    when(stackServiceMock.getAll(board.id)).thenAnswer((_) async {
      return [];
    });

    Get.parameters = <String, String>{'boardId': '1'};
    final controller = Get.put(KanbanBoardController());

    controller.boardId = 1;
    expect(controller.boardId, 1);
    expect(controller.stackData, []);

    var oldCardIndex = 1;
    var newCardIndex = 0;

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
            draggedCard.id!, draggedCard, -1, draggedToStack.id))
        .thenAnswer((_) async => draggedCard);
    when(notifyServiceMock.successMsg('Card', 'Card Updated Successfully'))
        .thenReturn(null);
    controller.stackData = [draggedFromStack, draggedToStack];

    await controller.cardReorderHandler(
        oldCardIndex, newCardIndex, draggedFromStack.id, draggedToStack.id);

    verify(cardServiceMock.reorderCard(board.id, draggedFromStack.id,
            draggedCard.id!, draggedCard, -1, draggedToStack.id))
        .called(1);

    verify(notifyServiceMock.successMsg('Card', 'Card Updated Successfully'))
        .called(1);
  });

  test('reordering to different empty stack', () async {
    var board = NC.Board(title: 'foo', id: 1);
    when(boardServiceMock.getBoard(board.id)).thenAnswer((_) async {
      return board;
    });
    when(stackServiceMock.getAll(board.id)).thenAnswer((_) async {
      return [];
    });

    Get.parameters = <String, String>{'boardId': '1'};
    final controller = Get.put(KanbanBoardController());

    controller.boardId = 1;
    expect(controller.boardId, 1);
    expect(controller.stackData, []);

    var oldCardIndex = 1;
    var newCardIndex = 0;

    var draggedFromStack =
        NC.Stack(title: "backlog", id: 18, boardId: board.id);
    var draggedToStack =
        NC.Stack(title: "in progress", id: 20, boardId: board.id);
    var draggedCard =
        NC.Card(title: "issue1", id: 1, stackId: draggedFromStack.id);
    var card2 = NC.Card(title: "issue2", id: 2, stackId: draggedFromStack.id);
    draggedFromStack.cards = [card2, draggedCard];
    expect(draggedFromStack.cards[oldCardIndex].id, draggedCard.id);

    draggedToStack.cards = [];

    when(cardServiceMock.reorderCard(board.id, draggedFromStack.id,
            draggedCard.id!, draggedCard, 0, draggedToStack.id))
        .thenAnswer((_) async => draggedCard);
    when(notifyServiceMock.successMsg('Card', 'Card Updated Successfully'))
        .thenReturn(null);
    controller.stackData = [draggedFromStack, draggedToStack];

    await controller.cardReorderHandler(
        oldCardIndex, newCardIndex, draggedFromStack.id, draggedToStack.id);

    verify(cardServiceMock.reorderCard(board.id, draggedFromStack.id,
            draggedCard.id!, draggedCard, 0, draggedToStack.id))
        .called(1);

    verify(notifyServiceMock.successMsg('Card', 'Card Updated Successfully'))
        .called(1);
  });
}
