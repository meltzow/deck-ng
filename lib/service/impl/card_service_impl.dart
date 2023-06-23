import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:get/get.dart';

class CardServiceImpl extends GetxService implements ICardService {
  final httpService = Get.find<IHttpService>();

  @override
  Future<Card> createCard(int boardId, int stackId, String title) async {
    dynamic response = await httpService.post(
        "/index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards",
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
}
