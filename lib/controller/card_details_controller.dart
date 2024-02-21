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
  late RxString descriptionControllerText = 'Initial Text'.obs;
  late RxString titleControllerText = 'Initial Text'.obs;

  final Rxn<card.Card> _cardData = Rxn<card.Card>();
  final Rxn<Board> _boardData = Rxn<Board>();

  final ICardService _cardService = Get.find<ICardService>();
  final IBoardService _boardService = Get.find<IBoardService>();

  card.Card? get cardData => _cardData.value;
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

  saveLabels(List<Label> newLabels) async {
    _cardData.value?.labels = newLabels;
    await _cardService.updateCard(
        _boardId.value!, _stackId.value!, _cardId.value!, _cardData.value!);
  }
}
