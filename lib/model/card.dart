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
  final int? id;
  List<Label> labels = [];
  String? lastEditor;
  @EpochDateTimeConverter()
  DateTime? lastModified;
  @JsonKey(defaultValue: 0)
  late int order;
  int? overdue;
  late User? owner;
  late int stackId;
  String title;
  String type;
  DateTime? done;
  bool? notified;
  List<User>? participants;
  Stack? relatedStack;
  Board? relatedBoard;

  Card({
    this.ETag,
    this.archived,
    this.assignedUsers,
    this.attachmentCount,
    this.attachments,
    this.commentsCount,
    this.commentsUnread,
    this.createdAt,
    this.deletedAt,
    this.description,
    this.duedate,
    this.id,
    this.labels = const <Label>[],
    this.lastEditor,
    this.lastModified,
    required this.order,
    this.overdue,
    required this.owner,
    required this.stackId,
    required this.title,
    required this.type,
    this.done,
    this.notified,
    this.participants,
    this.relatedStack,
    this.relatedBoard,
  });

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);

  Card copyWith({
    String? ETag,
    bool? archived,
    List<Assignment>? assignedUsers,
    int? attachmentCount,
    List<Attachment>? attachments,
    int? commentsCount,
    int? commentsUnread,
    DateTime? createdAt,
    DateTime? deletedAt,
    String? description,
    DateTime? duedate,
    int? id,
    List<Label>? labels,
    String? lastEditor,
    DateTime? lastModified,
    int? order,
    int? overdue,
    User? owner,
    int? stackId,
    String? title,
    String? type,
    DateTime? done,
    bool? notified,
    List<User>? participants,
    Stack? relatedStack,
    Board? relatedBoard,
  }) {
    return Card(
      ETag: ETag ?? this.ETag,
      archived: archived ?? this.archived,
      assignedUsers: assignedUsers ?? this.assignedUsers,
      attachmentCount: attachmentCount ?? this.attachmentCount,
      attachments: attachments ?? this.attachments,
      commentsCount: commentsCount ?? this.commentsCount,
      commentsUnread: commentsUnread ?? this.commentsUnread,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      description: description ?? this.description,
      duedate: duedate ?? this.duedate,
      id: id ?? this.id,
      labels: labels ?? this.labels,
      lastEditor: lastEditor ?? this.lastEditor,
      lastModified: lastModified ?? this.lastModified,
      order: order ?? this.order,
      overdue: overdue ?? this.overdue,
      owner: owner ?? this.owner,
      stackId: stackId ?? this.stackId,
      title: title ?? this.title,
      type: type ?? this.type,
      done: done ?? this.done,
      notified: notified ?? this.notified,
      participants: participants ?? this.participants,
      relatedStack: relatedStack ?? this.relatedStack,
      relatedBoard: relatedBoard ?? this.relatedBoard,
    );
  }
}
