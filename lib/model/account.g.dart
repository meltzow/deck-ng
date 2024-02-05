// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      json['username'] as String,
      json['password'] as String,
      json['authData'] as String,
      json['url'] as String,
      json['isAuthenticated'] as bool,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'authData': instance.authData,
      'url': instance.url,
      'isAuthenticated': instance.isAuthenticated,
    };
