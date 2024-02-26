import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/model/card.dart' as card;
import 'package:deck_ng/model/label.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDetailsController extends GetxController {
  final RxBool isLoading = RxBool(true);
  final RxnInt _boardId = RxnInt();
  final RxnInt _stackId = RxnInt();

  final RxnInt _cardId = RxnInt();

  RxBool isDescriptionEditing = RxBool(false);
  RxBool isTitleEditing = RxBool(false);
  final TextEditingController _descriptionEditingController =
      TextEditingController();
  final TextEditingController _titleEditingController = TextEditingController();
  late RxString descriptionControllerText = ''.obs;
  late RxString titleControllerText = ''.obs;

  late final Rxn<card.Card> _cardData = Rxn<card.Card>();
  final Rxn<Board> _boardData = Rxn<Board>();

  final ICardService _cardService = Get.find<ICardService>();
  final IBoardService _boardService = Get.find<IBoardService>();

  card.Card? get cardData => _cardData.value;

  TextEditingController? get descriptionEditingController =>
      _descriptionEditingController;
  TextEditingController get titleController => _titleEditingController;

  List<Label?> get allLabel => _boardData.value!.labels;

  @visibleForTesting
  set boardId(int boardId) => _boardId.value = boardId;
  @visibleForTesting
  set stackId(int stackId) => _stackId.value = stackId;

  @visibleForTesting
  set cardId(int cardId) => _cardId.value = cardId;

  @visibleForTesting
  set cardData(card.Card? card) => _cardData.value = card;

  @override
  void onClose() {
    _descriptionEditingController.dispose();
    _titleEditingController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    _titleEditingController.addListener(() {
      titleControllerText.value = _titleEditingController.text;
    });
    _descriptionEditingController.addListener(() {
      descriptionControllerText.value = _descriptionEditingController.text;
    });

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    _boardId.value = Get.arguments['boardId'] as int;
    _stackId.value = Get.arguments['stackId'] as int;
    _cardId.value = Get.arguments['cardId'] as int;
    await refreshData();
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    _cardData.value = await _cardService.getCard(
        _boardId.value!, _stackId.value!, _cardId.value!);
    _boardData.value = await _boardService.getBoard(_boardId.value!);
    titleControllerText.value = _cardData.value!.title;
    descriptionControllerText.value = _cardData.value!.description ?? '';
    _titleEditingController.text = titleControllerText.value;
    _descriptionEditingController.text = descriptionControllerText.value;
    isLoading.value = false;
  }

  saveCard() {
    _cardData.value!.title = titleControllerText.value;
    _cardData.value!.description = descriptionControllerText.value;

    _cardService.updateCard(
        _boardId.value!, _stackId.value!, _cardId.value!, _cardData.value!);
    Get.showSnackbar(
      const GetSnackBar(
        title: 'Card',
        message: 'Card Updated Successfully',
        icon: Icon(Icons.update),
        duration: Duration(seconds: 3),
      ),
    );
  }

  saveLabels(List<Label> selectedLabels) async {
    var newLabels =
        selectedLabels.toSet().difference(_cardData.value!.labels.toSet());
    var removeLabels =
        _cardData.value!.labels.toSet().difference(selectedLabels.toSet());

    for (var element in newLabels) {
      _cardData.value = await _cardService.assignLabel2Card(
          _boardId.value!, _stackId.value!, _cardId.value!, element.id!);
    }

    for (var element in removeLabels) {
      _cardData.value = await _cardService.removeLabel2Card(
          _boardId.value!, _stackId.value!, _cardId.value!, element.id!);
    }
  }
}
