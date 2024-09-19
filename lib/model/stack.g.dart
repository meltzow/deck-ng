// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stack _$StackFromJson(Map<String, dynamic> json) => Stack(
      title: json['title'] as String? ?? '',
      boardId: (json['boardId'] as num).toInt(),
      deletedAt: _$JsonConverterFromJson<int, DateTime>(
          json['deletedAt'], const EpochDateTimeConverter().fromJson),
      cards: (json['cards'] as List<dynamic>?)
              ?.map((e) => Card.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      id: (json['id'] as num).toInt(),
      order: (json['order'] as num?)?.toInt() ?? 0,
    )
      ..lastModified = _$JsonConverterFromJson<int, DateTime>(
          json['lastModified'], const EpochDateTimeConverter().fromJson)
      ..ETag = json['ETag'] as String;

Map<String, dynamic> _$StackToJson(Stack instance) => <String, dynamic>{
      'title': instance.title,
      'boardId': instance.boardId,
      'deletedAt': _$JsonConverterToJson<int, DateTime>(
          instance.deletedAt, const EpochDateTimeConverter().toJson),
      'lastModified': _$JsonConverterToJson<int, DateTime>(
          instance.lastModified, const EpochDateTimeConverter().toJson),
      'cards': instance.cards.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'order': instance.order,
      'ETag': instance.ETag,
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
