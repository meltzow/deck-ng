import 'package:deck_ng/model/card.dart';

abstract class ICardService {
  Future<Card> createCard(int boardId, int stackId, String title);
}
