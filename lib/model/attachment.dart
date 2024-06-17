import 'dart:core';

import 'package:deck_ng/model/converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attachment.g.dart';

@JsonSerializable(explicitToJson: true)
class Attachment {
  late int cardId;
  late String type;
  late String
      data; // Change this to List<int> if you want to store the file data as bytes
  late int? lastModified;
  late int? createdAt;
  late String createdBy; // Change this to int if your user ID is an integer
  @EpochDateTimeConverter()
  DateTime? deletedAt;
  late ExtendedData extendedData;
  late int id;

  Attachment(
      {required this.cardId,
      required this.type,
      required this.data,
      this.lastModified,
      this.createdAt,
      required this.createdBy,
      this.deletedAt,
      required this.extendedData,
      required this.id});

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ExtendedData {
  int?
      filesize; // Change this to double if you're storing the file size in kilobytes, megabytes, etc.
  late String mimetype;
  late Info info;

  ExtendedData({this.filesize, required this.mimetype, required this.info});

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

  Info(
      {required this.dirname,
      required this.basename,
      required this.extension,
      required this.filename});

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
