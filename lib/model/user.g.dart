// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      primaryKey: json['primaryKey'] as String,
      uid: json['uid'] as String,
      displayname: json['displayname'] as String,
      type: json['type'] as int,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'primaryKey': instance.primaryKey,
      'uid': instance.uid,
      'displayname': instance.displayname,
      'type': instance.type,
    };
