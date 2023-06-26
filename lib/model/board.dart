import 'dart:ffi';

import 'package:deck_ng/model/label.dart';

class Board {
  final String title;
  final String? color;
  final Bool? archived;
  final int id;
  final String? acl;
  final int? shared;
  final DateTime? deletedAt;
  final DateTime? lastModified;
  List<Label>? labels;

  Board(
      {required this.title,
      this.color,
      this.archived,
      this.acl,
      this.shared,
      this.deletedAt,
      this.lastModified,
      required this.id,
      this.labels});

  factory Board.fromJson(Map<String, dynamic> json) {
    var labels =
        (json['labels'] as List).map((e) => Label.fromJson(e)).toList();
    return Board(
      title: json['title'] as String,
      id: json['id'] as int,
      color: json['color'] as String?,
      // archived: json['archived'] as Bool?,
      labels: labels,
      // acl: json['acl'] as String[]?,

      // permissions?: BoardPermissions;
      // users?: Array<User>;
      // shared: json['shared'] as Int?,
      // deletedAt:  json['deletedAt'] as DateTime?,
      // lastModified: json['lastModified'] as DateTime?,
      // settings:json['settings'] as BoardSettings;
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'color': color,
        'labels': labels?.map((e) => e.toJson()).toList()
      };
}
