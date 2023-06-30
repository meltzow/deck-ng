// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      json['cardId'] as int,
      json['type'] as String,
      json['data'] as String,
      json['lastModified'] as int?,
      json['createdAt'] as int?,
      json['createdBy'] as String,
      json['deletedAt'] as int?,
      ExtendedData.fromJson(json['extendedData'] as Map<String, dynamic>),
      json['id'] as int,
    );

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'type': instance.type,
      'data': instance.data,
      'lastModified': instance.lastModified,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'deletedAt': instance.deletedAt,
      'extendedData': instance.extendedData.toJson(),
      'id': instance.id,
    };

ExtendedData _$ExtendedDataFromJson(Map<String, dynamic> json) => ExtendedData(
      json['filesize'] as int?,
      json['mimetype'] as String,
      Info.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExtendedDataToJson(ExtendedData instance) =>
    <String, dynamic>{
      'filesize': instance.filesize,
      'mimetype': instance.mimetype,
      'info': instance.info.toJson(),
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      json['dirname'] as String,
      json['basename'] as String,
      json['extension'] as String,
      json['filename'] as String,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'dirname': instance.dirname,
      'basename': instance.basename,
      'extension': instance.extension,
      'filename': instance.filename,
    };
