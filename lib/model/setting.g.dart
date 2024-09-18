// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting(
      json['language'] as String,
      optOut: json['optOut'] as bool? ?? false,
    );

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'language': instance.language,
      'optOut': instance.optOut,
    };
