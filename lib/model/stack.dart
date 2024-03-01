import 'package:deck_ng/model/card.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stack.g.dart';

@JsonSerializable(explicitToJson: true)
class Stack {
  final String title;
  final int? boardId;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  late DateTime? deletedAt;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  late DateTime? lastModified;
  List<Card> cards;
  final int id;
  late int? order;
  late String? ETag;

  Stack(
      {required this.title,
      this.boardId,
      this.deletedAt,
      required this.cards,
      required this.id});

  factory Stack.fromJson(Map<String, dynamic> json) => _$StackFromJson(json);

  Map<String, dynamic> toJson() => _$StackToJson(this);

  static int _toJson(DateTime? time) => time!.millisecondsSinceEpoch;

  static DateTime? _fromJson(int int) =>
      DateTime.fromMillisecondsSinceEpoch(int);
}
