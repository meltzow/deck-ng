import 'package:deck_ng/model/models.dart';
import 'package:json_annotation/json_annotation.dart';

class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(int json) =>
      DateTime.fromMillisecondsSinceEpoch(json * 1000);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch ~/ 1000;
}

Object mapUser(value) {
  if (value is Map<String, dynamic>) {
    return User.fromJson(value);
  }
  if (value is String) {
    return value;
  }
  throw 'Cannot convert $value to User';
}
