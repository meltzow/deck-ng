import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CardDetailsController extends GetxController {
  final RxBool isLoading = RxBool(true);
  final RxnInt _boardId = RxnInt();
  final RxnInt _stackId = RxnInt();
  final RxnInt _cardId = RxnInt();

  RxBool isEditingText = RxBool(false);
  late TextEditingController _editingController;
  RxString descriptionControllerText = 'Initial Text'.obs;

  late final Rxn<Card> _cardData = Rxn<Card>();

  final ICardService _cardRepository = Get.find<ICardService>();

  Card? get cardData => _cardData.value;
  TextEditingController? get editingController => _editingController;

  @override
  void onClose() {
    _editingController.dispose();
    super.onClose();
  }

  @override
  void onReady() async {
    super.onReady();
    _editingController =
        TextEditingController(text: descriptionControllerText.value);
    _boardId.value = Get.arguments['boardId'] as int;
    _stackId.value = Get.arguments['stackId'] as int;
    _cardId.value = Get.arguments['cardId'] as int;
    await refreshData();
  }

  Future<void> refreshData() async {
    _cardData.value = await _cardRepository
        .getCard(_boardId!.value!, _stackId!.value!, _cardId!.value!)
        .whenComplete(() => isLoading.value = false);
  }
}
