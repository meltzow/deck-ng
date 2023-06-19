import 'dart:ffi';

class Board {
  final String title;
  final String? color;
  final Bool? archived;
  final int id;
  final String? acl;
  final int? shared;
  final DateTime? deletedAt;
  final DateTime? lastModified;

  Board(
      {required this.title,
      this.color,
      this.archived,
      this.acl,
      this.shared,
      this.deletedAt,
      this.lastModified,
      required this.id});

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      title: json['title'] as String,
      id: json['id'] as int,
      color: json['color'] as String?,
      // archived: json['archived'] as Bool?,
      // labels: json['labels'] as Label?,
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
      };
}
