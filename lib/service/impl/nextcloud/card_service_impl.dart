import 'dart:convert';

import 'package:deck_ng/model/assignment.dart';
import 'package:deck_ng/model/attachment.dart';
import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/service/card_service.dart';
import 'package:deck_ng/service/http_service.dart';
import 'package:get/get.dart';

class CardServiceImpl extends GetxService implements CardService {
  final httpService = Get.find<HttpService>();

  @override
  Future<Card> createCard(int boardId, int stackId, String title) async {
    dynamic response = await httpService.post(
        "/index.php/apps/deck/api/v1/boards/$boardId/stacks/$stackId/cards",
        {'title': title});
    Card card = Card.fromJson(response);
    return card;
  }

  @override
  Future<Card> updateCard(
      int boardId, int stackId, int cardId, Card card) async {
    dynamic response = await httpService.put(
        "/index.php/apps/deck/api/v1/boards/$boardId/stacks/$stackId/cards/$cardId",
        card);
    Card cardResp = Card.fromJson(response);

    return cardResp;
  }

  @override
  Future<void> deleteCard(int boardId, int stackId, int cardId) {
    // TODO: implement deleteCard
    throw UnimplementedError();
  }

  @override
  Future<Card> getCard(int boardId, int stackId, int cardId) async {
    dynamic response = await httpService.get(
        "/index.php/apps/deck/api/v1/boards/$boardId/stacks/$stackId/cards/$cardId");
    return Card.fromJson(response);
  }

  /// see https://deck.readthedocs.io/en/latest/API/#cards
  /// PUT /boards/{boardId}/stacks/{stackId}/cards/{cardId}/assignLabel
  @override
  Future<void> assignLabel2Card(
      int boardId, int stackId, int cardId, int labelId) async {
    httpService.put<void>(
        "/index.php/apps/deck/api/v1/boards/$boardId/stacks/$stackId/cards/$cardId/assignLabel",
        json.encode({'labelId': labelId}));
  }

  /// @see https://deck.readthedocs.io/en/latest/API/#cards
  ///PUT /boards/{boardId}/stacks/{stackId}/cards/{cardId}/removeLabel
  @override
  Future<void> removeLabel2Card(
      int boardId, int stackId, int cardId, int labelId) async {
    httpService.put<void>(
        "/index.php/apps/deck/api/v1/boards/$boardId/stacks/$stackId/cards/$cardId/removeLabel",
        json.encode({'labelId': labelId}));
  }

  //return this.httpService.put<Card>(`/index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards/${cardId}/assignUser`,
  //         {userId:userId})
  @override
  Future<Assignment> assignUser2Card(
      int boardId, int stackId, int cardId, String userId) async {
    var responseData = await httpService.put(
        '/index.php/apps/deck/api/v1/boards/$boardId/stacks/$stackId/cards/$cardId/assignUser',
        json.encode({'userId': userId}));

    return Assignment.fromJson(responseData);
  }

  //return this.httpService.put<Card>(`/index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards/${cardId}/unassignUser`,
  //         {userId:userId})
  @override
  Future<Assignment> unassignUser2Card(
      int boardId, int stackId, int cardId, String userId) async {
    var responseData = await httpService.put(
        '/index.php/apps/deck/api/v1/boards/$boardId/stacks/$stackId/cards/$cardId/unassignUser',
        json.encode({'userId': userId}));

    return Assignment.fromJson(responseData);
  }

  @override
  Future<Card> reorderCard(int boardId, int oldStackId, int cardId, Card card,
      int newOrder, int newStackId) async {
    card.order = newOrder;
    card.stackId = newStackId;
    return updateCard(boardId, oldStackId, cardId, card);

    //TODO: its service answers with httpStatus 403
    // var responseData = await httpService.put(
    //     '/index.php/apps/deck/api/v1/boards/$boardId/stacks/$oldStackId/cards/$cardId/reorder',
    //     json.encode({'order': newOrder}));
    // List<dynamic> mediaList = (responseData as List);
    // return mediaList;
  }

  @override
  Future<Attachment> addAttachmentToCard(
      int boardId, int stackId, int cardId, Attachment attachment) async {
    var responseData = await httpService.post(
        '/index.php/apps/deck/api/v1/boards/$boardId/stacks/$stackId/cards/$cardId/attachments',
        json.encode({'type': 'deck_file', 'file': attachment.data}));

    return Attachment.fromJson(responseData);
  }
}
