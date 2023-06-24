import 'package:deck_ng/model/card.dart';

abstract class ICardService {
  Future<Card> createCard(int boardId, int stackId, String title);

  Future<Card> updateCard(int boardId, int stackId, int cardId, Card card);

  Future<Card> getCard(int boardId, int stackId, int cardId);

  Future<void> deleteCard(int boardId, int stackId, int cardId);

  // public assignLabel2Card(boardId: number, stackId: number, cardId: number, labelId: number): Promise<Card> {
  // public removeLabel2Card(boardId: number, stackId: number, cardId: number, labelId: number): Promise<Card> {
  // public assignUser2Card(boardId: number, stackId: number, cardId: number, userId: string): Promise<Card> {
  // public unassignUser2Card(boardId: number, stackId: number, cardId: number, userId: string): Promise<Card> {
}
