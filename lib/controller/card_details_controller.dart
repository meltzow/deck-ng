import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

  final ICardService _cardRepository = Get.find<ICardService>();

  Card? get cardData => _cardData.value;
  TextEditingController? get descriptionEditingController =>
      _descriptionEditingController;
  TextEditingController? get titleController => _titleEditingController;

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
    _descriptionEditingController =
        TextEditingController(text: descriptionControllerText.value);
    _titleEditingController =
        TextEditingController(text: titleControllerText.value);
  }

  Future<void> refreshData() async {
    _cardData.value = (await _cardRepository
        .getCard(_boardId!.value!, _stackId!.value!, _cardId!.value!)
        .whenComplete(() => isLoading.value = false));
  }
}
