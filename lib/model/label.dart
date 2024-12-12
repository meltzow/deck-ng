// lib/model/label.dart

import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

part 'label.g.dart';

@JsonSerializable(explicitToJson: true)
class Label {
  String title;
  String? color;
  int? boardId;
  int? lastModified;
  int? id;
  String? ETAG;
  int? cardId;

  Label({
    required this.title,
    this.color,
    required this.id,
    this.boardId,
    this.lastModified,
    this.ETAG,
    this.cardId,
  });

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);

  Map<String, dynamic> toJson() => _$LabelToJson(this);

  Color get color1 => Color(int.parse('0xFF$color'));
}
