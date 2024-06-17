// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      username: json['username'] as String,
      password: json['password'] as String,
      authData: json['authData'] as String,
      url: json['url'] as String,
      isAuthenticated: json['isAuthenticated'] as bool,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'authData': instance.authData,
      'url': instance.url,
      'isAuthenticated': instance.isAuthenticated,
    };
