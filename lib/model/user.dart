import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  late String primaryKey;
  late String uid;
  late String displayname;
  late int type;

  User(
      {required this.primaryKey,
      required this.uid,
      required this.displayname,
      required this.type});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
