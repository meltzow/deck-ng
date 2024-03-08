import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String primaryKey;
  final String uid;
  final String displayname;
  final int type;

  const User(
      {this.primaryKey = '',
      this.uid = '',
      this.displayname = '',
      this.type = 0});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
