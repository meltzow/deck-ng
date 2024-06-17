import 'package:deck_ng/model/models.dart';

abstract class CardService {
  Future<Card> createCard(int boardId, int stackId, String title);

  Future<Card> updateCard(int boardId, int stackId, int cardId, Card card);

  Future<Card> getCard(int boardId, int stackId, int cardId);

  Future<void> deleteCard(int boardId, int stackId, int cardId);

  Future<Card> reorderCard(int boardId, int oldStackId, int cardId, Card card,
      int newOrder, int newStackId);

  Future<void> assignLabel2Card(
      int boardId, int stackId, int cardId, int labelId);

  Future<void> removeLabel2Card(
      int boardId, int stackId, int cardId, int labelId);

  Future<Assignment> assignUser2Card(
      int boardId, int stackId, int cardId, String userId);

  Future<Assignment> unassignUser2Card(
      int boardId, int stackId, int cardId, String userId);

  Future<Attachment> addAttachmentToCard(
      int boardId, int stackId, int cardId, Attachment attachment);
}
