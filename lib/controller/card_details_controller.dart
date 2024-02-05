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
  TextEditingController _titleEditingController = TextEditingController();
  late RxString descriptionControllerText = 'Initial Text'.obs;
  late RxString titleControllerText = 'Initial Text'.obs;

  final Rxn<Card> _cardData = Rxn<Card>();
  final Rxn<Board> _boardData = Rxn<Board>();

  final ICardService _cardService = Get.find<ICardService>();
  final IBoardService _boardService = Get.find<IBoardService>();

  Card? get cardData => _cardData.value;
  TextEditingController? get descriptionEditingController =>
      _descriptionEditingController;
  TextEditingController get titleController => _titleEditingController;

  List<Label?> get allLabel => _boardData.value!.labels;

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
    descriptionControllerText.value =
        _cardData.value?.description ?? 'Initial Text';
    titleControllerText.value = _cardData.value!.title;
    _descriptionEditingController =
        TextEditingController(text: descriptionControllerText.value);
    _titleEditingController.text = titleControllerText.value;
    isLoading.value = false;
  }

  saveCard() {
    _cardData.value!.title = titleControllerText.value;

    _cardService.updateCard(
        _boardId.value!, _stackId.value!, _cardId.value!, _cardData.value!);
  }

  saveLabels(List<Label> newLabels) async {
    _cardData.value?.labels = newLabels;
    await _cardService.updateCard(
        _boardId.value!, _stackId.value!, _cardId.value!, _cardData.value!);
  }
}
