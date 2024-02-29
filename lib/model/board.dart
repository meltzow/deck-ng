import 'package:deck_ng/model/label.dart';
import 'package:deck_ng/model/user.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'board.g.dart';

@JsonSerializable(explicitToJson: true)
class Board {
  final String title;
  final String? color;
  final bool? archived;
  final int id;
  late List? acl;
  final int? shared;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime? deletedAt;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime? lastModified;
  late List<Label> labels;
  late List<User> users;

  Board(
      {required this.title,
      this.color,
      this.archived,
      this.acl,
      this.shared,
      this.deletedAt,
      this.lastModified,
      required this.id,
      List<Label>? labels})
      : labels = labels ?? [];

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  Map<String, dynamic> toJson() => _$BoardToJson(this);

  static DateTime? _fromJson(int int) =>
      DateTime.fromMillisecondsSinceEpoch(int);

  static int _toJson(DateTime? time) => time!.millisecondsSinceEpoch;

  Label? findLabelById(int id) {
    return labels.firstWhereOrNull((element) => element.id == id);
  }
}
