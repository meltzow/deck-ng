import 'package:appflowy_board/appflowy_board.dart';
import 'package:deck_ng/model/models.dart' as NC;
import 'package:deck_ng/screen/kanban_board_screen.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Inotification_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardDetailsController extends GetxController {
  late AppFlowyBoardController boardController;

  final Rxn<NC.Board> _boardsData = Rxn<NC.Board>();
  final Rx<List<NC.Stack>> _stackData = Rx<List<NC.Stack>>([]);
  late final int _boardId;
  // final Rxn<int> _selectedStackId = Rxn();
  final RxBool isLoading = RxBool(true);

  int get boardId => _boardId;

  Map<int, Widget> get myTabs {
    Map<int, Widget> m = <int, Widget>{};
    for (var element in _stackData.value) {
      m[element.id] = Text(element.title);
    }
    return m;
  }

  final IBoardService _boardService = Get.find<IBoardService>();
  final IStackService _stackService = Get.find<IStackService>();
  final ICardService _cardService = Get.find<ICardService>();
  final INotificationService _notificationService =
      Get.find<INotificationService>();

  NC.Board? get boardData => _boardsData.value;

  @visibleForTesting
  set boardId(int value) => _boardId = value;

  @visibleForTesting
  set stackData(List<NC.Stack> stacks) => _stackData.value = stacks;

  List<NC.Stack> get stackData => _stackData.value;

  AppFlowyBoardController get boardCtl => boardController;

  @override
  void onReady() async {
    super.onReady();
    _boardId = Get.arguments['boardId'] as int;
    await refreshData();
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    _boardsData.value = await _boardService.getBoard(_boardId);
    _stackData.value = (await _stackService.getAll(_boardId))!
      ..sort((a, b) => a.order!.compareTo(b.order!));
    // _selectedStackId.value =
    //     _stackData.value.isNotEmpty ? _stackData.value[0].id : null;

    boardController = AppFlowyBoardController(
      // onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      //   debugPrint('Move item from $fromIndex to $toIndex');
      // },
      onMoveGroupItem: (groupId, fromIndex, toIndex) {
        reorder(int.parse(groupId) - 1, fromIndex, toIndex);
      },
      onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        cardReorderHandler(fromIndex, toIndex, int.parse(fromGroupId) - 1,
            int.parse(toGroupId) - 1);
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

  void reorder(int selectedStackIndex, int oldIndex, int newIndex) async {
    var oldCard = _stackData.value[selectedStackIndex].cards[newIndex];

    NC.Card currentDraggedCard =
        _stackData.value[selectedStackIndex].cards.removeAt(oldIndex);
    _stackData.value[selectedStackIndex].cards
        .insert(newIndex, currentDraggedCard);

    var newOrderValue = 0;
    if (newIndex > oldIndex) {
      newOrderValue = oldCard.order + 1;
    } else {
      newOrderValue = oldCard.order - 1;
    }
    currentDraggedCard.order = newOrderValue;

    var card1 = await _cardService.updateCard(_boardId,
        currentDraggedCard.stackId, currentDraggedCard.id, currentDraggedCard);
    cardSuccessMsg();
  }

  cardReorderHandler(int oldCardIndex, int newCardIndex, int oldListIndex,
      int newListIndex) async {
    // find card at old index and old list/stack
    var draggedCard = _stackData.value[oldListIndex].cards[oldCardIndex];
    var cardAtNewPosition =
        _stackData.value[newListIndex].cards.elementAtOrNull(newCardIndex);
    if (cardAtNewPosition != null) {
      draggedCard.order = cardAtNewPosition.order - 1;
    } else {
      var cardAtNewPositionMinus1 = _stackData.value[newListIndex].cards
          .elementAtOrNull(newCardIndex - 1);
      if (cardAtNewPositionMinus1 != null) {
        draggedCard.order = cardAtNewPositionMinus1.order + 1;
      } else {
        draggedCard.order = 0;
      }
    }
    // set at card new index and new stack
    // card.stackId = _stackData.value[newListIndex!].id;
    //save card
    var group = await _cardService.reorderCard(
        _boardId,
        _stackData.value[oldListIndex].id,
        draggedCard.id,
        draggedCard,
        draggedCard.order,
        _stackData.value[newListIndex].id);

    cardSuccessMsg();
  }

  void cardSuccessMsg() {
    _notificationService.successMsg('Card', 'Card Updated Successfully');
  }
}
