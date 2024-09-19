// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardSetting _$BoardSettingFromJson(Map<String, dynamic> json) => BoardSetting()
  ..notifyDue = json['notify-due'] as String
  ..calendar = json['calendar'] as bool;

Map<String, dynamic> _$BoardSettingToJson(BoardSetting instance) =>
    <String, dynamic>{
      'notify-due': instance.notifyDue,
      'calendar': instance.calendar,
    };

Board _$BoardFromJson(Map<String, dynamic> json) => Board(
      title: json['title'] as String? ?? '',
      color: json['color'] as String?,
      archived: json['archived'] as bool? ?? false,
      acl: json['acl'] as List<dynamic>?,
      shared: (json['shared'] as num?)?.toInt(),
      deletedAt: _$JsonConverterFromJson<int, DateTime>(
          json['deletedAt'], const EpochDateTimeConverter().fromJson),
      lastModified: _$JsonConverterFromJson<int, DateTime>(
          json['lastModified'], const EpochDateTimeConverter().fromJson),
      id: (json['id'] as num).toInt(),
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      owner: json['owner'] == null
          ? const User()
          : User.fromJson(json['owner'] as Map<String, dynamic>),
      labels: (json['labels'] as List<dynamic>?)
              ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    )
      ..permission = (json['permission'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          {}
      ..stacks = (json['stacks'] as List<dynamic>?)
              ?.map((e) => Stack.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'title': instance.title,
      'color': instance.color,
      'archived': instance.archived,
      'id': instance.id,
      'acl': instance.acl,
      'shared': instance.shared,
      'deletedAt': _$JsonConverterToJson<int, DateTime>(
          instance.deletedAt, const EpochDateTimeConverter().toJson),
      'lastModified': _$JsonConverterToJson<int, DateTime>(
          instance.lastModified, const EpochDateTimeConverter().toJson),
      'labels': instance.labels.map((e) => e.toJson()).toList(),
      'users': instance.users.map((e) => e.toJson()).toList(),
      'owner': instance.owner.toJson(),
      'permission': instance.permission,
      'stacks': instance.stacks.map((e) => e.toJson()).toList(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
