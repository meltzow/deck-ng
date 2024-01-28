// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Iauth_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppPassword _$AppPasswordFromJson(Map<String, dynamic> json) => AppPassword(
      Ocs.fromJson(json['ocs'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppPasswordToJson(AppPassword instance) =>
    <String, dynamic>{
      'ocs': instance.ocs,
    };

Ocs _$OcsFromJson(Map<String, dynamic> json) => Ocs(
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OcsToJson(Ocs instance) => <String, dynamic>{
      'meta': instance.meta,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['apppassword'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'apppassword': instance.apppassword,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      json['status'] as String,
      json['statuscode'] as int,
      json['message'] as String,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'status': instance.status,
      'statuscode': instance.statuscode,
      'message': instance.message,
    };
