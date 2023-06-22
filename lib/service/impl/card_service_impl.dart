import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:get/get.dart';

class CardServiceImpl extends GetxService implements ICardService {
  final httpService = Get.find<IHttpService>();

  @override
  Future<Card> createCard(int boardId, int stackId, String title) async {
    dynamic response = await httpService
        .post("/index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards", {'title': title});
    Card card = Card.fromJson(response);
    return card;

  }
}
