// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Iauth_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppPassword _$AppPasswordFromJson(Map<String, dynamic> json) => AppPassword(
      AppPasswordOcs.fromJson(json['ocs'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppPasswordToJson(AppPassword instance) =>
    <String, dynamic>{
      'ocs': instance.ocs,
    };

Capabilities _$CapabilitiesFromJson(Map<String, dynamic> json) => Capabilities(
      CapabilitiesOcs.fromJson(json['ocs'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CapabilitiesToJson(Capabilities instance) =>
    <String, dynamic>{
      'ocs': instance.ocs,
    };

CapabilitiesOcs _$CapabilitiesOcsFromJson(Map<String, dynamic> json) =>
    CapabilitiesOcs(
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      data: CapabilitiesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CapabilitiesOcsToJson(CapabilitiesOcs instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'data': instance.data,
    };

AppPasswordOcs _$AppPasswordOcsFromJson(Map<String, dynamic> json) =>
    AppPasswordOcs(
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      data: AppPasswordData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppPasswordOcsToJson(AppPasswordOcs instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'data': instance.data,
    };

Version _$VersionFromJson(Map<String, dynamic> json) => Version(
      json['major'] as int,
      json['minor'] as int,
      json['micro'] as int,
      json['string'] as String,
      json['edition'] as String,
      json['extendedSupport'] as bool,
    );

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
      'major': instance.major,
      'minor': instance.minor,
      'micro': instance.micro,
      'string': instance.string,
      'edition': instance.edition,
      'extendedSupport': instance.extendedSupport,
    };

Deck _$DeckFromJson(Map<String, dynamic> json) => Deck(
      json['version'] as String,
      json['canCreateBoards'] as bool,
      (json['apiVersions'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DeckToJson(Deck instance) => <String, dynamic>{
      'version': instance.version,
      'canCreateBoards': instance.canCreateBoards,
      'apiVersions': instance.apiVersions,
    };

Capability _$CapabilityFromJson(Map<String, dynamic> json) => Capability(
      Deck.fromJson(json['deck'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CapabilityToJson(Capability instance) =>
    <String, dynamic>{
      'deck': instance.deck,
    };

CapabilitiesData _$CapabilitiesDataFromJson(Map<String, dynamic> json) =>
    CapabilitiesData(
      Version.fromJson(json['version'] as Map<String, dynamic>),
      json['capabilities'],
    );

Map<String, dynamic> _$CapabilitiesDataToJson(CapabilitiesData instance) =>
    <String, dynamic>{
      'version': instance.version,
      'capabilities': instance.capabilities,
    };

AppPasswordData _$AppPasswordDataFromJson(Map<String, dynamic> json) =>
    AppPasswordData(
      json['apppassword'] as String,
    );

Map<String, dynamic> _$AppPasswordDataToJson(AppPasswordData instance) =>
    <String, dynamic>{
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
