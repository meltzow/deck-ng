// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assignment _$AssignmentFromJson(Map<String, dynamic> json) => Assignment(
      json['cardId'] as int,
      json['id'] as int,
      User.fromJson(json['participant'] as Map<String, dynamic>),
      json['type'] as int,
    );

Map<String, dynamic> _$AssignmentToJson(Assignment instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'id': instance.id,
      'participant': instance.participant,
      'type': instance.type,
    };
