// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map<String, dynamic> json) => Board(
      title: json['title'] as String,
      color: json['color'] as String?,
      archived: json['archived'] as bool?,
      acl: json['acl'] as List<dynamic>?,
      shared: json['shared'] as int?,
      deletedAt: Board._fromJson(json['deletedAt'] as int),
      lastModified: Board._fromJson(json['lastModified'] as int),
      id: json['id'] as int,
      labels: (json['labels'] as List<dynamic>?)
          ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..users = (json['users'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'title': instance.title,
      'color': instance.color,
      'archived': instance.archived,
      'id': instance.id,
      'acl': instance.acl,
      'shared': instance.shared,
      'deletedAt': Board._toJson(instance.deletedAt),
      'lastModified': Board._toJson(instance.lastModified),
      'labels': instance.labels.map((e) => e.toJson()).toList(),
      'users': instance.users.map((e) => e.toJson()).toList(),
    };
