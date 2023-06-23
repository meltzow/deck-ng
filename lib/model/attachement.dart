import 'dart:core';
import 'dart:ffi';

class Attachement {
  late int cardId;
  late String type;
  late String data;
  late Int? lastModified;
  late int? createdAt;
  late String createdBy;
  int? deletedAt;
  late ExtendedData extendedData;
  late int id;
}

class ExtendedData {
  int? filesize;
  late String mimetype;
  late Info info;
}

class Info {
  late String dirname;
  late String basename;
  late String extension;
  late String filename;
}
