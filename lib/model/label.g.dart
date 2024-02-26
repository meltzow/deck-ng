// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Label _$LabelFromJson(Map<String, dynamic> json) => Label(
      title: json['title'] as String,
      color: json['color'] as String?,
      id: json['id'] as int?,
      boardId: json['boardId'] as int?,
      lastModified: json['lastModified'] as int?,
      ETAG: json['ETAG'] as String?,
      cardId: json['cardId'] as int?,
    );

Map<String, dynamic> _$LabelToJson(Label instance) => <String, dynamic>{
      'title': instance.title,
      'color': instance.color,
      'boardId': instance.boardId,
      'lastModified': instance.lastModified,
      'id': instance.id,
      'ETAG': instance.ETAG,
      'cardId': instance.cardId,
    };
