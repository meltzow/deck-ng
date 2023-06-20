import 'package:deck_ng/model/card.dart' as NCCard;

class Stack {
  final String title;
  final int? boardId;
  final int? deletedAt;
  final List<NCCard.Card> cards;
  final int id;
  // final String? color;
  // final Bool? archived;
  // // final Array<String>? labels;
  // final String? acl;
  // final Int? shared;
  // final DateTime? deletedAt;
  // final DateTime? lastModified;

  Stack(
      {required this.title,
      this.boardId,
      this.deletedAt,
      required this.cards,
      required this.id});

  factory Stack.fromJson(Map<String, dynamic> json) {
    final cardsData = json['cards'] as List<dynamic>?;
    final cards = cardsData != null
        // map each review to a Review object
        ? cardsData
            .map((reviewData) => NCCard.Card.fromJson(reviewData))
            // map() returns an Iterable so we convert it to a List
            .toList() // use an empty list as fallback value
        : <NCCard.Card>[];

    return Stack(
      title: json['title'] as String,
      boardId: json['boardId'] as int?,
      deletedAt: json['deletedAt'] as int?,
      // cast to a nullable list as the cards may be missing
      cards: cards,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
      };
}
