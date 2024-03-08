// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting()
  ..notifyDue = json['notify-due'] as String
  ..calendar = json['calendar'] as bool;

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'notify-due': instance.notifyDue,
      'calendar': instance.calendar,
    };

Board _$BoardFromJson(Map<String, dynamic> json) => Board(
      title: json['title'] as String,
      color: json['color'] as String?,
      archived: json['archived'] as bool? ?? false,
      acl: json['acl'] as List<dynamic>?,
      shared: json['shared'] as int?,
      deletedAt: _$JsonConverterFromJson<int, DateTime>(
          json['deletedAt'], const EpochDateTimeConverter().fromJson),
      lastModified: _$JsonConverterFromJson<int, DateTime>(
          json['lastModified'], const EpochDateTimeConverter().fromJson),
      id: json['id'] as int,
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
    )..permission = (json['permission'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      );

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
