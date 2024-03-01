// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stack _$StackFromJson(Map<String, dynamic> json) => Stack(
      title: json['title'] as String,
      boardId: json['boardId'] as int?,
      deletedAt: Stack._fromJson(json['deletedAt'] as int),
      cards: (json['cards'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int,
    )
      ..lastModified = Stack._fromJson(json['lastModified'] as int)
      ..order = json['order'] as int?
      ..ETag = json['ETag'] as String?;

Map<String, dynamic> _$StackToJson(Stack instance) => <String, dynamic>{
      'title': instance.title,
      'boardId': instance.boardId,
      'deletedAt': Stack._toJson(instance.deletedAt),
      'lastModified': Stack._toJson(instance.lastModified),
      'cards': instance.cards.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'order': instance.order,
      'ETag': instance.ETag,
    };
