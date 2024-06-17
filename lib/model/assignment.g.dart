// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assignment _$AssignmentFromJson(Map<String, dynamic> json) => Assignment(
      cardId: (json['cardId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      participant: User.fromJson(json['participant'] as Map<String, dynamic>),
      type: (json['type'] as num).toInt(),
    );

Map<String, dynamic> _$AssignmentToJson(Assignment instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'id': instance.id,
      'participant': instance.participant.toJson(),
      'type': instance.type,
    };
