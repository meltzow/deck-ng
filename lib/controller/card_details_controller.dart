import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:wiredash/wiredash.dart' as wd;

class CardDetailsController extends GetxController {
  var card = Rx<Card?>(null);
  var board = Rx<Board?>(null);
  var users = <User>[].obs;
  var attachments = <Attachment>[].obs;
  var labels = <Label>[].obs;
  var selectedLabels = <Label>[].obs;
  var markdownPreview = ''.obs;
  var isEditMode = false.obs;

  final CardService _cardService = Get.find<CardService>();
  final BoardService _boardService = Get.find<BoardService>();
  final NotificationService _notificationService =
      Get.find<NotificationService>();

  final material.TextEditingController titleController =
      material.TextEditingController();
  final material.TextEditingController descriptionController =
      material.TextEditingController();
  final material.TextEditingController duedateController =
      material.TextEditingController();

  late RxInt boardId;
  late RxInt stackId;
  late RxInt cardId;

  @override
  void onReady() async {
    super.onReady();
    boardId = RxInt(int.parse(Get.parameters['boardId']!));
    stackId = RxInt(int.parse(Get.parameters['stackId']!));
    cardId = RxInt(int.parse(Get.parameters['cardId']!));
    fetchCard();
    fetchAttachments();
    fetchBoard();
  }

  Future<void> fetchCard() async {
    card.value = null;
    card.value = (await _cardService.getCard(
        boardId.value, stackId.value, cardId.value));

    if (card.value != null) {
      titleController.text = card.value!.title;
      descriptionController.text = card.value!.description ?? '';
      duedateController.text = card.value!.duedate != null
          ? card.value!.duedate!.toIso8601String()
          : '';
      markdownPreview.value = card.value!.description ?? '';
    }
  }

  void updateMarkdownPreview(String text) {
    markdownPreview.value = text;
  }

  void fetchAttachments() {
    //FIXME: Fetch attachments from service
  }

  void fetchBoard() async {
    board.value = null;
    board.value = (await _boardService.getBoard(boardId.value));

    if (board.value != null) {
      labels.value = board.value!.labels;
      users.value = board.value!.users;
    }
  }

  Future<void> updateCard(Card card) async {
    card.title = titleController.text;
    card.description = descriptionController.text;

    var updatedCard = await _cardService.updateCard(
        boardId.value, stackId.value, this.card.value!.id!, card);
    this.card.value = updatedCard;
    // Display success message
    _notificationService.successMsg('Card', 'Card updated successfully');
  }

  void addLabel(Label label) {
    card.value = card.value?.copyWith(
      labels: [...card.value!.labels, label],
    );
    wd.Wiredash.trackEvent("add Label", data: {"label": label.title});
  }

  void removeLabel(Label label) {
    card.value = card.value?.copyWith(
      labels: card.value!.labels.where((l) => l.title != label.title).toList(),
    );
    wd.Wiredash.trackEvent("remove Label", data: {"label": label.title});
  }

  void addUser(User user) async {
    var assignment = await _cardService.assignUser2Card(
        boardId.value, stackId.value, cardId.value, user.uid);
    card.value = card.value?.copyWith(
      assignedUsers: [...?card.value?.assignedUsers, assignment],
    );
    wd.Wiredash.trackEvent("add User");
  }

  void removeUser(User user) async {
    var assignment = await _cardService.unassignUser2Card(
        boardId.value, stackId.value, cardId.value, user.uid);

    card.value = card.value?.copyWith(
      assignedUsers: card.value?.assignedUsers
          ?.where((a) => a.participant.uid != user.uid)
          .toList(),
    );
    wd.Wiredash.trackEvent("remove User");
  }

  void clearDueDate() {
    card.value?.duedate = null;
    duedateController.text = '';
  }
}
