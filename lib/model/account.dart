import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable(explicitToJson: true)
class Account {
  late String username;
  late String password;
  late String authData;
  late String url;

  late bool isAuthenticated;

  Account(this.username, this.password, this.authData, this.url,
      this.isAuthenticated);

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
