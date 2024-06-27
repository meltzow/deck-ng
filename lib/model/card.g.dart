// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      ETag: json['ETag'] as String?,
      archived: json['archived'] as bool?,
      assignedUsers: (json['assignedUsers'] as List<dynamic>?)
          ?.map((e) => Assignment.fromJson(e as Map<String, dynamic>))
          .toList(),
      attachmentCount: (json['attachmentCount'] as num?)?.toInt(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      commentsCount: (json['commentsCount'] as num?)?.toInt(),
      commentsUnread: (json['commentsUnread'] as num?)?.toInt(),
      createdAt: _$JsonConverterFromJson<int, DateTime>(
          json['createdAt'], const EpochDateTimeConverter().fromJson),
      deletedAt: _$JsonConverterFromJson<int, DateTime>(
          json['deletedAt'], const EpochDateTimeConverter().fromJson),
      description: json['description'] as String?,
      duedate: json['duedate'] == null
          ? null
          : DateTime.parse(json['duedate'] as String),
      id: (json['id'] as num?)?.toInt(),
      labels: (json['labels'] as List<dynamic>?)
              ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Label>[],
      lastEditor: json['lastEditor'] as String?,
      lastModified: _$JsonConverterFromJson<int, DateTime>(
          json['lastModified'], const EpochDateTimeConverter().fromJson),
      order: (json['order'] as num?)?.toInt() ?? 0,
      overdue: (json['overdue'] as num?)?.toInt(),
      owner: json['owner'] == null ? '' : mapUser(json['owner']),
      stackId: (json['stackId'] as num).toInt(),
      title: json['title'] as String,
      type: json['type'] as String?,
      done:
          json['done'] == null ? null : DateTime.parse(json['done'] as String),
      notified: json['notified'] as bool?,
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      relatedStack: json['relatedStack'] == null
          ? null
          : Stack.fromJson(json['relatedStack'] as Map<String, dynamic>),
      relatedBoard: json['relatedBoard'] == null
          ? null
          : Board.fromJson(json['relatedBoard'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'ETag': instance.ETag,
      'archived': instance.archived,
      'assignedUsers': instance.assignedUsers?.map((e) => e.toJson()).toList(),
      'attachmentCount': instance.attachmentCount,
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
      'commentsCount': instance.commentsCount,
      'commentsUnread': instance.commentsUnread,
      'createdAt': _$JsonConverterToJson<int, DateTime>(
          instance.createdAt, const EpochDateTimeConverter().toJson),
      'deletedAt': _$JsonConverterToJson<int, DateTime>(
          instance.deletedAt, const EpochDateTimeConverter().toJson),
      'description': instance.description,
      'duedate': instance.duedate?.toIso8601String(),
      'id': instance.id,
      'labels': instance.labels.map((e) => e.toJson()).toList(),
      'lastEditor': instance.lastEditor,
      'lastModified': _$JsonConverterToJson<int, DateTime>(
          instance.lastModified, const EpochDateTimeConverter().toJson),
      'order': instance.order,
      'overdue': instance.overdue,
      'owner': instance.owner,
      'stackId': instance.stackId,
      'title': instance.title,
      'type': instance.type,
      'done': instance.done?.toIso8601String(),
      'notified': instance.notified,
      'participants': instance.participants?.map((e) => e.toJson()).toList(),
      'relatedStack': instance.relatedStack?.toJson(),
      'relatedBoard': instance.relatedBoard?.toJson(),
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
