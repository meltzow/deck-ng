import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'attachment.g.dart';

@JsonSerializable(explicitToJson: true)
class Attachment {
  late int cardId;
  late String type;
  late String data;
  late int? lastModified;
  late int? createdAt;
  late String createdBy;
  int? deletedAt;
  late ExtendedData extendedData;
  late int id;

  Attachment(
      this.cardId,
      this.type,
      this.data,
      this.lastModified,
      this.createdAt,
      this.createdBy,
      this.deletedAt,
      this.extendedData,
      this.id);

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ExtendedData {
  int? filesize;
  late String mimetype;
  late Info info;

  ExtendedData(this.filesize, this.mimetype, this.info);

  factory ExtendedData.fromJson(Map<String, dynamic> json) =>
      _$ExtendedDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendedDataToJson(this);
}

@JsonSerializable()
class Info {
  late String dirname;
  late String basename;
  late String extension;
  late String filename;

  Info(this.dirname, this.basename, this.extension, this.filename);

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
