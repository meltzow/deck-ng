// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      cardId: (json['cardId'] as num).toInt(),
      type: json['type'] as String,
      data: json['data'] as String,
      lastModified: (json['lastModified'] as num?)?.toInt(),
      createdAt: (json['createdAt'] as num?)?.toInt(),
      createdBy: json['createdBy'] as String,
      deletedAt: _$JsonConverterFromJson<int, DateTime>(
          json['deletedAt'], const EpochDateTimeConverter().fromJson),
      extendedData:
          ExtendedData.fromJson(json['extendedData'] as Map<String, dynamic>),
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'type': instance.type,
      'data': instance.data,
      'lastModified': instance.lastModified,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'deletedAt': _$JsonConverterToJson<int, DateTime>(
          instance.deletedAt, const EpochDateTimeConverter().toJson),
      'extendedData': instance.extendedData.toJson(),
      'id': instance.id,
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

ExtendedData _$ExtendedDataFromJson(Map<String, dynamic> json) => ExtendedData(
      filesize: (json['filesize'] as num?)?.toInt(),
      mimetype: json['mimetype'] as String,
      info: Info.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExtendedDataToJson(ExtendedData instance) =>
    <String, dynamic>{
      'filesize': instance.filesize,
      'mimetype': instance.mimetype,
      'info': instance.info.toJson(),
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      dirname: json['dirname'] as String,
      basename: json['basename'] as String,
      extension: json['extension'] as String,
      filename: json['filename'] as String,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'dirname': instance.dirname,
      'basename': instance.basename,
      'extension': instance.extension,
      'filename': instance.filename,
    };
