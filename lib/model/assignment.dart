import 'package:deck_ng/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assignment.g.dart';

@JsonSerializable(explicitToJson: true)
class Assignment {
  late int cardId;
  late int id;
  late User participant;
  late int type;

  Assignment(this.cardId, this.id, this.participant, this.type);

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentToJson(this);
}
