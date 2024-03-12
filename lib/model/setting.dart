import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

@JsonSerializable(explicitToJson: true)
class Setting {
  late String language;

  Setting(this.language);

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);
}
