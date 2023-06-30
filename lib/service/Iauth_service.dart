import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'Iauth_service.g.dart';

@JsonSerializable()
class Poll {
  late String token;
  late String endpoint;

  Poll(this.token, this.endpoint);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PollToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginPollInfo {
  late Poll poll;
  late String login;

  LoginPollInfo(this.poll, this.login);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory LoginPollInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginPollInfoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$LoginPollInfoToJson(this);
}

@JsonSerializable()
class LoginCredentials {
  late String server;
  late String loginName;
  late String appPassword;

  LoginCredentials(this.server, this.loginName, this.appPassword);

  factory LoginCredentials.fromJson(Map<String, dynamic> json) =>
      _$LoginCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$LoginCredentialsToJson(this);
}

abstract class IAuthService {
  Future<bool> login(String fullUrl);
}
