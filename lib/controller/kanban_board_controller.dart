import 'package:appflowy_board/appflowy_board.dart';
import 'package:deck_ng/model/models.dart' as NC;
import 'package:deck_ng/screen/kanban_board_screen.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KanbanBoardController extends GetxController {
  late AppFlowyBoardController boardController;

  final Rxn<NC.Board> _boardsData = Rxn<NC.Board>();
  final Rx<List<NC.Stack>> _stackData = Rx<List<NC.Stack>>([]);
  late int boardId;
  // final Rxn<int> _selectedStackId = Rxn();
  final RxBool isLoading = RxBool(true);

  final BoardService _boardService = Get.find<BoardService>();
  final StackService _stackService = Get.find<StackService>();
  final CardService _cardService = Get.find<CardService>();
  final NotificationService _notificationService =
      Get.find<NotificationService>();

  NC.Board? get boardData => _boardsData.value;

  @visibleForTesting
  set stackData(List<NC.Stack> stacks) => _stackData.value = stacks;

  List<NC.Stack> get stackData => _stackData.value;

  AppFlowyBoardController get boardCtl => boardController;

  @override
  void onInit() async {
    super.onInit();
    boardId = int.parse(Get.parameters['boardId']!);
    refreshData();
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    _boardsData.value = await _boardService.getBoard(boardId);
    _stackData.value = (await _stackService.getAll(boardId))!
      ..sort((a, b) => a.order.compareTo(b.order));
    // _selectedStackId.value =
    //     _stackData.value.isNotEmpty ? _stackData.value[0].id : null;

    boardController = AppFlowyBoardController(
      // onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      //   debugPrint('Move item from $fromIndex to $toIndex');
      // },
      onMoveGroupItem: (groupId, fromIndex, toIndex) {
        reorder(int.parse(groupId), fromIndex, toIndex);
      },
      onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        cardReorderHandler(
            fromIndex, toIndex, int.parse(fromGroupId), int.parse(toGroupId));
      },
    );
    for (var stack in _stackData.value) {
      List<AppFlowyGroupItem> items = [];
      for (var card in stack.cards) {
        items.add(CardItem(card));
      }
      final group1 = AppFlowyGroupData<Stack>(
        id: stack.id.toString(),
        items: items,
        name: stack.title,
      );
      group1.draggable = false;
      boardController.addGroup(group1);
    }
    isLoading.value = false;
  }

  // addCard(String title) {
  //   _cardService.createCard(boardId, _selectedStackId.value!, title);
  // }

  NC.Stack? _findStackById(int stackId) {
    return _stackData.value
        .firstWhereOrNull((element) => element.id == stackId);
  }

  void reorder(int selectedStackIndex, int oldIndex, int newIndex) async {
    var stack = _findStackById(selectedStackIndex)!;
    var oldCard = stack.cards[newIndex];

    NC.Card currentDraggedCard = stack.cards.removeAt(oldIndex);
    stack.cards.insert(newIndex, currentDraggedCard);

    var newOrderValue = 0;
    if (newIndex > oldIndex) {
      newOrderValue = oldCard.order + 1;
    } else {
      newOrderValue = oldCard.order - 1;
    }
    currentDraggedCard.order = newOrderValue;

    var card1 = await _cardService.updateCard(boardId,
        currentDraggedCard.stackId, currentDraggedCard.id!, currentDraggedCard);

    cardSuccessMsg();
  }

  cardReorderHandler(
      int oldCardIndex, int newCardIndex, int oldListId, int newListId) async {
    var oldStack = _findStackById(oldListId)!;
    var newStack = _findStackById(newListId)!;

    var draggedCard = oldStack.cards[oldCardIndex];
    var cardAtNewPosition = newStack.cards.elementAtOrNull(newCardIndex);
    if (cardAtNewPosition != null) {
      draggedCard.order = cardAtNewPosition.order - 1;
    } else {
      var cardAtNewPositionMinus1;
      if (newCardIndex - 1 >= 0) {
        cardAtNewPositionMinus1 =
            newStack.cards.elementAtOrNull(newCardIndex - 1);
      }
      if (cardAtNewPositionMinus1 != null) {
        draggedCard.order = cardAtNewPositionMinus1.order + 1;
      } else {
        draggedCard.order = 0;
      }
    }
    // set at card new index and new stack
    // card.stackId = _stackData.value[newListIndex!].id;
    //save card
    var group = await _cardService.reorderCard(boardId, oldStack.id,
        draggedCard.id!, draggedCard, draggedCard.order, newStack.id);

    cardSuccessMsg();
  }

  void cardSuccessMsg() {
    _notificationService.successMsg('Card', 'Card Updated Successfully');
  }

  // In the KanbanBoardController
  void createCard(int stackId, String title) async {
    var newCard =
        NC.Card(title: title, stackId: stackId, order: _stackData.value.length);
    var createdCard = await _cardService.createCard(boardId, stackId, title);
    var stack = _findStackById(stackId);
    stack!.cards.add(createdCard);
    cardSuccessMsg();
  }
}
