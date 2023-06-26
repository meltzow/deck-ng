import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/model/label.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/board.dart';

class CardDetailsController extends GetxController {
  final RxBool isLoading = RxBool(true);
  final RxnInt _boardId = RxnInt();
  final RxnInt _stackId = RxnInt();
  final RxnInt _cardId = RxnInt();

  RxBool isDescriptionEditing = RxBool(false);
  RxBool isTitleEditing = RxBool(false);
  late TextEditingController _descriptionEditingController;
  late TextEditingController _titleEditingController;
  late RxString descriptionControllerText = 'Initial Text'.obs;
  late RxString titleControllerText = 'Initial Text'.obs;

  late final Rxn<Card> _cardData = Rxn<Card>();
  late final Rxn<Board> _boardData = Rxn<Board>();

  final ICardService _cardService = Get.find<ICardService>();
  final IBoardService _boardService = Get.find<IBoardService>();

  Card? get cardData => _cardData.value;
  TextEditingController? get descriptionEditingController =>
      _descriptionEditingController;
  TextEditingController? get titleController => _titleEditingController;

  List<Label>? get allLabel => _boardData.value?.labels;

  @override
  void onClose() {
    _descriptionEditingController.dispose();
    _titleEditingController.dispose();
    super.onClose();
  }

  @override
  void onReady() async {
    super.onReady();

    _boardId.value = Get.arguments['boardId'] as int;
    _stackId.value = Get.arguments['stackId'] as int;
    _cardId.value = Get.arguments['cardId'] as int;
    await refreshData();
    descriptionControllerText.value =
        _cardData.value?.description ?? 'Initial Text';
    titleControllerText.value = _cardData.value!.title;
    _descriptionEditingController =
        TextEditingController(text: descriptionControllerText.value);
    _titleEditingController =
        TextEditingController(text: titleControllerText.value);
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    _cardData.value = await _cardService.getCard(
        _boardId!.value!, _stackId!.value!, _cardId!.value!);
    _boardData.value = await _boardService.getBoard(_boardId.value!);
    isLoading.value = false;
  }

  saveLabels(List<Label> newLabels) async {
    _cardData.value?.labels = newLabels;
    await _cardService.updateCard(
        _boardId.value!, _stackId.value!, _cardId.value!, _cardData.value!);
  }
}
