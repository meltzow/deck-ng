import 'package:appflowy_board/appflowy_board.dart';
import 'package:deck_ng/model/models.dart' as NC;
import 'package:deck_ng/screen/kanban_board_screen.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
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

  NC.Board? get boardData => _boardsData.value;

  // int? get selectedStackId => _selectedStackId.value;

  // NC.Stack? get selectedStackData => _stackData.value.isNotEmpty
  //     ? _stackData.value
  //         .firstWhere((element) => element.id == _selectedStackId.value)
  //     : null;

  @visibleForTesting
  set boardId(int value) => _boardId = value;

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
      onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        debugPrint('Move item from $fromIndex to $toIndex');
      },
      onMoveGroupItem: (groupId, fromIndex, toIndex) {
        reorder(int.parse(groupId) - 1, fromIndex, toIndex);
        debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
      },
      onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        cardReorderHandler(fromIndex, toIndex, fromGroupId, toGroupId);
        debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
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

  // Future<void> selectStack(int stackId) async {
  //   _selectedStackId.value = stackId;
  // }

  // swipeToStack({direction = const {'left': 'right'}}) {
  //   var idx = _stackData.value
  //       .indexWhere((element) => element.id == _selectedStackId.value);
  //   var newIdx = direction == 'left' ? idx - 1 : idx + 1;
  //   if (_stackData.value.asMap().containsKey(newIdx)) {
  //     _selectedStackId.value = _stackData.value[newIdx].id;
  //   }
  // }

  // addCard(String title) {
  //   _cardService.createCard(boardId, _selectedStackId.value!, title);
  // }

  void reorder(int selectedStackId, int oldIndex, int newIndex) async {
    var oldCard = _stackData.value[selectedStackId].cards[newIndex];

    NC.Card currentDraggedCard =
        _stackData.value[selectedStackId].cards.removeAt(oldIndex);
    _stackData.value[selectedStackId].cards
        .insert(newIndex, currentDraggedCard);

    var newOrderValue = 0;
    if (newIndex > oldIndex) {
      newOrderValue = oldCard.order + 1;
    } else {
      newOrderValue = oldCard.order - 1;
    }
    currentDraggedCard.order = newOrderValue;

    var card1 = await _cardService.reorderCard(_boardId, selectedStackId,
        oldCard.id, oldCard, newOrderValue, selectedStackId);
    cardSuccessMsg();
  }

  cardReorderHandler(int oldCardIndex, int newCardIndex, String oldListIndex,
      String newListIndex) async {
    // find card at old index and old list/stack
    var card = _stackData.value[int.parse(oldListIndex)].cards[oldCardIndex];
    var orderMustIncreased = (oldCardIndex < newCardIndex) ? true : false;
    // var neighborCard = _stackData.value[newListIndex].cards[newListIndex]
    // if (orderMustIncreased)
    // set at card new index and new stack
    // card.stackId = _stackData.value[newListIndex!].id;
    //save card
    var group = await _cardService.reorderCard(
        _boardId,
        _stackData.value[int.parse(oldListIndex)].id,
        card.id,
        card,
        card.order,
        _stackData.value[int.parse(newListIndex)].id);

    cardSuccessMsg();
  }

  void cardSuccessMsg() {
    Get.showSnackbar(
      const GetSnackBar(
        title: 'Card',
        message: 'Card Updated Successfully',
        icon: Icon(Icons.update),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
