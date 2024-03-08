import 'package:deck_ng/model/card.dart';
import 'package:deck_ng/model/converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stack.g.dart';

@JsonSerializable(explicitToJson: true)
class Stack {
  final String title;
  final int boardId;
  @EpochDateTimeConverter()
  late DateTime? deletedAt;
  @EpochDateTimeConverter()
  late DateTime? lastModified;
  @JsonKey(defaultValue: <Card>[])
  late List<Card> cards;
  late int id;
  late int? order;
  late String ETag;

  Stack(
      {required this.title,
      required this.boardId,
      this.deletedAt,
      this.cards = const <Card>[],
      required this.id});

  factory Stack.fromJson(Map<String, dynamic> json) => _$StackFromJson(json);

  Map<String, dynamic> toJson() => _$StackToJson(this);
}
