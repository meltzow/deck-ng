import 'package:deck_ng/model/models.dart';
import 'package:deck_ng/service/services.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';

class CardDetailsController extends GetxController {
  var card = Rx<Card?>(null);
  var board = Rx<Board?>(null);
  var users = <User>[].obs;
  var attachments = <Attachment>[].obs;
  var labels = <Label>[].obs;
  var selectedLabels = <Label>[].obs;

  final CardService _cardService = Get.find<CardService>();
  final BoardService _boardService = Get.find<BoardService>();

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
    }
  }

  void fetchAttachments() {
    //FIXME: Fetch attachments from service
    // // Beispielanhänge aus der Datenbank
    // var attachmentResponse = [
    //   {'name': 'Attachment1', 'url': 'https://example.com/file1'},
    //   {'name': 'Attachment2', 'url': 'https://example.com/file2'},
    // ];
    //
    // attachments.value =
    //     attachmentResponse.map((e) => Attachment.fromJson(e)).toList();
  }

  void fetchBoard() async {
    board.value = null;
    board.value = (await _boardService.getBoard(boardId.value));

    if (board.value != null) {
      labels.value = board.value!.labels;
      users.value = board.value!.users;
    }
  }

  void updateCard(Card card) async {
    final updatedCard = Card(
      ETag: card.ETag,
      archived: card.archived,
      assignedUsers: card.assignedUsers,
      attachmentCount: card.attachmentCount,
      attachments: card.attachments,
      commentsCount: card.commentsCount,
      commentsUnread: card.commentsUnread,
      createdAt: card.createdAt,
      deletedAt: card.deletedAt,
      description: descriptionController.text,
      duedate: DateTime.tryParse(duedateController.text),
      id: card.id,
      labels: card.labels,
      lastEditor: card.lastEditor,
      lastModified: DateTime.now(),
      order: card.order,
      overdue: card.overdue,
      owner: card.owner,
      stackId: card.stackId,
      title: titleController.text,
      type: card.type,
      done: card.done,
      notified: card.notified,
      participants: card.participants,
      relatedStack: card.relatedStack,
      relatedBoard: card.relatedBoard,
    );

    await _cardService.updateCard(
        boardId.value, stackId.value, this.card.value!.id!, updatedCard);
    this.card.value = updatedCard;
    // Display success message
    Get.snackbar('Success', 'Card updated successfully');
  }

  void addLabel(Label label) {
    card.value = card.value?.copyWith(
      labels: [...card.value!.labels, label],
    );
  }

  void removeLabel(Label label) {
    card.value = card.value?.copyWith(
      labels: card.value!.labels.where((l) => l.title != label.title).toList(),
    );
  }

  void addUser(User user) async {
    var assignment = await _cardService.assignUser2Card(
        boardId.value, stackId.value, cardId.value, user.uid);
    card.value = card.value?.copyWith(
      assignedUsers: [...?card.value?.assignedUsers, assignment],
    );
  }

  void removeUser(User user) async {
    var assignment = await _cardService.unassignUser2Card(
        boardId.value, stackId.value, cardId.value, user.uid);

    card.value = card.value?.copyWith(
      assignedUsers: card.value?.assignedUsers
          ?.where((a) => a.participant.uid != user.uid)
          .toList(),
    );
  }

  // void addAttachment(FilePickerResult result) async {
  //   var file = result.files.single;
  //   // Create an Attachment object from the selected file
  //   Attachment attachment = Attachment(
  //     cardId: card.value!.id!,
  //     type: 'file',
  //     data: base64Encode(file.bytes!),
  //     lastModified: DateTime.now().millisecondsSinceEpoch,
  //     createdAt: DateTime.now().millisecondsSinceEpoch,
  //     createdBy: 'Your User ID', // Replace with the actual user ID
  //     deletedAt: null,
  //     extendedData: ExtendedData(
  //       filesize: file.size,
  //       mimetype: file.extension!,
  //       info: Info(
  //         dirname: 'Directory Name', // Replace with the actual directory name
  //         basename: 'Base Name', // Replace with the actual base name
  //         extension: file.extension!,
  //         filename: file.name,
  //       ),
  //     ),
  //     id: 0, // Replace with the actual ID
  //   );
  //
  //   await _cardService.addAttachmentToCard(
  //       boardId.value, stackId.value, cardId.value, attachment);
  //
  //   card.value = card.value?.copyWith(
  //     attachments: [...?card.value?.attachments, attachment],
  //   );
  // }
  //
  // void removeAttachment(Attachment attachment) {
  //   card.value = card.value?.copyWith(
  //     attachments: card.value?.attachments
  //         ?.where((a) =>
  //             a.extendedData.info.filename !=
  //             attachment.extendedData.info.filename)
  //         .toList(),
  //   );
  // }
}
