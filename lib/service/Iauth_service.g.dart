// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Iauth_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poll _$PollFromJson(Map<String, dynamic> json) => Poll(
      json['token'] as String,
      json['endpoint'] as String,
    );

Map<String, dynamic> _$PollToJson(Poll instance) => <String, dynamic>{
      'token': instance.token,
      'endpoint': instance.endpoint,
    };

LoginPollInfo _$LoginPollInfoFromJson(Map<String, dynamic> json) =>
    LoginPollInfo(
      Poll.fromJson(json['poll'] as Map<String, dynamic>),
      json['login'] as String,
    );

Map<String, dynamic> _$LoginPollInfoToJson(LoginPollInfo instance) =>
    <String, dynamic>{
      'poll': instance.poll.toJson(),
      'login': instance.login,
    };

LoginCredentials _$LoginCredentialsFromJson(Map<String, dynamic> json) =>
    LoginCredentials(
      json['server'] as String,
      json['loginName'] as String,
      json['appPassword'] as String,
    );

Map<String, dynamic> _$LoginCredentialsToJson(LoginCredentials instance) =>
    <String, dynamic>{
      'server': instance.server,
      'loginName': instance.loginName,
      'appPassword': instance.appPassword,
    };
