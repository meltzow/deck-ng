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
  int? createdAt;
  int? deletedAt;
  String? description;
  DateTime? duedate;
  final int? id;
  List<Label> labels = [];
  String? lastEditor;
  int? lastModified;
  int? order;
  int? overdue;
  late User? owner;
  int? stackId;
  String title;
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
      this.order,
      this.stackId});

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}
