import 'dart:convert';

import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:get/get.dart';

class CardServiceImpl extends GetxService implements ICardService {
  final httpService = Get.find<IHttpService>();

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
}
