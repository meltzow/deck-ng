// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      title: json['title'] as String,
      description: json['description'] as String?,
      id: json['id'] as int?,
      type: json['type'] as String? ?? 'text',
      owner: json['owner'] == null
          ? null
          : User.fromJson(json['owner'] as Map<String, dynamic>),
      order: json['order'] as int?,
      stackId: json['stackId'] as int?,
    )
      ..ETag = json['ETag'] as String?
      ..archived = json['archived'] as bool?
      ..assignedUsers = (json['assignedUsers'] as List<dynamic>?)
          ?.map((e) => Assignment.fromJson(e as Map<String, dynamic>))
          .toList()
      ..attachmentCount = json['attachmentCount'] as int?
      ..attachments = (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList()
      ..commentsCount = json['commentsCount'] as int?
      ..commentsUnread = json['commentsUnread'] as int?
      ..createdAt = json['createdAt'] as int?
      ..deletedAt = json['deletedAt'] as int?
      ..duedate = json['duedate'] as String?
      ..labels = (json['labels'] as List<dynamic>?)
          ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
          .toList()
      ..lastEditor = json['lastEditor'] as String?
      ..lastModified = json['lastModified'] as int?
      ..overdue = json['overdue'] as int?;

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'ETag': instance.ETag,
      'archived': instance.archived,
      'assignedUsers': instance.assignedUsers?.map((e) => e.toJson()).toList(),
      'attachmentCount': instance.attachmentCount,
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
      'commentsCount': instance.commentsCount,
      'commentsUnread': instance.commentsUnread,
      'createdAt': instance.createdAt,
      'deletedAt': instance.deletedAt,
      'description': instance.description,
      'duedate': instance.duedate,
      'id': instance.id,
      'labels': instance.labels?.map((e) => e.toJson()).toList(),
      'lastEditor': instance.lastEditor,
      'lastModified': instance.lastModified,
      'order': instance.order,
      'overdue': instance.overdue,
      'owner': instance.owner?.toJson(),
      'stackId': instance.stackId,
      'title': instance.title,
      'type': instance.type,
    };
