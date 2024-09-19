import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/services.dart';
import 'package:deck_ng/service/tracking_service.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import this
import 'package:intl/intl.dart';

class CardDetailsController extends GetxController {
  var card = Rxn<Card?>(null);
  var board = Rxn<Board?>(null);
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
  final TrackingService _trackingService = Get.find<TrackingService>();

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
    await initializeDateFormatting(); // Initialize date formatting
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
          ? formatDueDate(card.value!.duedate!,
              material.Localizations.localeOf(Get.context!).toString())
          : '';
      markdownPreview.value = card.value!.description ?? '';
    }
  }

  String formatDueDate(DateTime date, String locale) {
    final DateFormat formatter = DateFormat.yMd(locale);
    return formatter.format(date);
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

    await _cardService.updateCard(
        boardId.value, stackId.value, this.card.value!.id!, card);
    fetchCard();
    // Display success message
    _notificationService.successMsg('Card', 'Card updated successfully');
  }

  void addLabel(Label label) {
    card.value = card.value?.copyWith(
      labels: [...card.value!.labels, label],
    );
    _trackingService.onButtonClickedEvent("add Label");
  }

  void removeLabel(Label label) {
    card.value = card.value?.copyWith(
      labels: card.value!.labels.where((l) => l.title != label.title).toList(),
    );
    _trackingService.onButtonClickedEvent("remove Label");
  }

  void addUser(User user) async {
    var assignment = await _cardService.assignUser2Card(
        boardId.value, stackId.value, cardId.value, user.uid);
    card.value = card.value?.copyWith(
      assignedUsers: [...?card.value?.assignedUsers, assignment],
    );
    _trackingService.onButtonClickedEvent("add User");
  }

  void removeUser(User user) async {
    var assignment = await _cardService.unassignUser2Card(
        boardId.value, stackId.value, cardId.value, user.uid);

    card.value = card.value?.copyWith(
      assignedUsers: card.value?.assignedUsers
          ?.where((a) => a.participant.uid != user.uid)
          .toList(),
    );
    _trackingService.onButtonClickedEvent("remove User");
  }

  void clearDueDate() {
    _trackingService.onButtonClickedEvent('clear Due Date');
    card.value?.duedate = null;
    duedateController.text = '';
  }
}
