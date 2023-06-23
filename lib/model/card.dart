import 'package:deck_ng/model/assigment.dart';
import 'package:deck_ng/model/attachement.dart';
import 'package:deck_ng/model/label.dart';
import 'package:deck_ng/model/user.dart';

class Card {
  String? ETag;
  bool? archived;
  List<Assignment>? assignedUsers;
  int? attachmentCount;
  List<Attachement>? attachments;
  int? commentsCount;
  int? commentsUnread;
  int? createdAt;
  int? deletedAt;
  final String? description;
  String? duedate;
  final int? id;
  List<Label>? labels;
  String? lastEditor;
  int? lastModified;
  int? order;
  int? overdue;
  late User? owner;
  int? stackId;
  final String title;
  String type;

  Card(
      {required this.title,
      this.description,
      required this.id,
      this.type = 'text',
      this.owner,
      this.order});

  factory Card.fromJson(Map<String, dynamic> json) {
    final ownerData = User.fromJson(json['owner']);
    return Card(
      title: json['title'] as String,
      id: json['id'] as int,
      description: json['description'] as String?,
      type: json['type'] as String,
      owner: ownerData,
      order: json['order'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'description': description,
        'type': type,
        'owner': owner!.toJson(),
        'order': order
      };
}
