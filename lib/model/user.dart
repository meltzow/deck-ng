import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      primaryKey: json['primaryKey'] as String,
      uid: json['uid'] as String,
      displayname: json['displayname'] as String,
      type: json['type'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'primaryKey': primaryKey,
        'uid': uid,
        'displayname': displayname,
        'type': type
      };
}
