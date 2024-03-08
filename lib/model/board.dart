import 'dart:ui';

import 'package:deck_ng/model/converter.dart';
import 'package:deck_ng/model/models.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'board.g.dart';

@JsonSerializable()
class Setting {
  @JsonKey(name: 'notify-due')
  late String notifyDue;
  late bool calendar;

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);

  Setting();
}

@JsonSerializable(explicitToJson: true)
class Board {
  final String title;
  final String? color;
  @JsonKey(defaultValue: false)
  late bool? archived = false;
  final int id;
  late List? acl;
  final int? shared;
  @EpochDateTimeConverter()
  final DateTime? deletedAt;
  @EpochDateTimeConverter()
  final DateTime? lastModified;
  @JsonKey(defaultValue: [])
  late List<Label> labels = [];
  @JsonKey(defaultValue: [])
  late List<User> users = [];
  late User owner;
  @JsonKey(defaultValue: {})
  late Map<String, bool>? permission = {};
  // late Setting? settings;

  Board(
      {required this.title,
      this.color,
      this.archived,
      this.acl,
      this.shared,
      this.deletedAt,
      this.lastModified,
      required this.id,
      this.users = const [],
      this.owner = const User(),
      List<Label>? labels})
      : labels = labels ?? [];

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  Map<String, dynamic> toJson() => _$BoardToJson(this);

  Label? findLabelById(int id) {
    return labels.firstWhereOrNull((element) => element.id == id);
  }

  Color get color1 => Color(int.parse('0xFF$color'));
}
