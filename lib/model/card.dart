import 'package:deck_ng/model/assignment.dart';
import 'package:deck_ng/model/attachment.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/model/converter.dart';
import 'package:deck_ng/model/label.dart';
import 'package:deck_ng/model/stack.dart';
import 'package:deck_ng/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@JsonSerializable(explicitToJson: true)
class Card {
  String? ETag;
  bool? archived;
  List<Assignment>? assignedUsers = [];
  int? attachmentCount;
  List<Attachment>? attachments;
  int? commentsCount;
  int? commentsUnread;
  @EpochDateTimeConverter()
  DateTime? createdAt;
  @EpochDateTimeConverter()
  DateTime? deletedAt;
  String? description;
  DateTime? duedate;
  final int id;
  List<Label> labels = [];
  String? lastEditor;
  @EpochDateTimeConverter()
  DateTime? lastModified;
  @JsonKey(defaultValue: 0)
  late int order;
  int? overdue;
  late User? owner;
  late int stackId;
  late String title = 'plain';
  String type;
  DateTime? done;
  bool? notified;
  List<User>? participants;
  Stack? relatedStack;
  Board? relatedBoard;

  Card(
      {required this.title,
      this.description,
      required this.id,
      this.type = 'text',
      this.owner,
      this.order = 0,
      required this.stackId});

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}
