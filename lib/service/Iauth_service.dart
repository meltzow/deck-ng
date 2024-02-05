import 'package:deck_ng/model/account.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Iauth_service.g.dart';

@JsonSerializable()
class AppPassword {
  late Ocs ocs;

  AppPassword(
    this.ocs,
  );

  factory AppPassword.fromJson(Map<String, dynamic> json) =>
      _$AppPasswordFromJson(json);
  Map<String, dynamic> toJson() => _$AppPasswordToJson(this);
}

@JsonSerializable()
class Ocs {
  late Meta meta;
  late Data data;

  Ocs({
    required this.meta,
    required this.data,
  });

  factory Ocs.fromJson(Map<String, dynamic> json) => _$OcsFromJson(json);
  Map<String, dynamic> toJson() => _$OcsToJson(this);
}

@JsonSerializable()
class Data {
  late String apppassword;

  Data(
    this.apppassword,
  );

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Meta {
  late String status;
  late int statuscode;
  late String message;

  Meta(
    this.status,
    this.statuscode,
    this.message,
  );

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

abstract class IAuthService {
  Future<bool> login(String serverUrl, String username, String password);

  bool isAuth();

  Account? getAccount();
}
