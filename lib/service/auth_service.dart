import 'package:deck_ng/model/account.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_service.g.dart';

@JsonSerializable()
class AppPassword {
  late AppPasswordOcs ocs;

  AppPassword(
    this.ocs,
  );

  factory AppPassword.fromJson(Map<String, dynamic> json) =>
      _$AppPasswordFromJson(json);
  Map<String, dynamic> toJson() => _$AppPasswordToJson(this);
}

@JsonSerializable()
class Capabilities {
  late CapabilitiesOcs ocs;

  Capabilities(
    this.ocs,
  );

  factory Capabilities.fromJson(Map<String, dynamic> json) =>
      _$CapabilitiesFromJson(json);
  Map<String, dynamic> toJson() => _$CapabilitiesToJson(this);
}

@JsonSerializable()
class CapabilitiesOcs {
  late Meta meta;
  late CapabilitiesData data;

  CapabilitiesOcs({
    required this.meta,
    required this.data,
  });

  factory CapabilitiesOcs.fromJson(Map<String, dynamic> json) =>
      _$CapabilitiesOcsFromJson(json);
  Map<String, dynamic> toJson() => _$CapabilitiesOcsToJson(this);
}

@JsonSerializable()
class AppPasswordOcs {
  late Meta meta;
  late AppPasswordData data;

  AppPasswordOcs({
    required this.meta,
    required this.data,
  });

  factory AppPasswordOcs.fromJson(Map<String, dynamic> json) =>
      _$AppPasswordOcsFromJson(json);
  Map<String, dynamic> toJson() => _$AppPasswordOcsToJson(this);
}

@JsonSerializable()
class Version {
  late int major;
  late int minor;
  late int micro;
  late String string;
  late String edition;
  late bool extendedSupport;

  Version(this.major, this.minor, this.micro, this.string, this.edition,
      this.extendedSupport);

  factory Version.fromJson(Map<String, dynamic> json) =>
      _$VersionFromJson(json);
  Map<String, dynamic> toJson() => _$VersionToJson(this);
}

@JsonSerializable()
class Deck {
  late String version;
  late bool canCreateBoards;
  late List<String> apiVersions;

  Deck(this.version, this.canCreateBoards, this.apiVersions);

  factory Deck.fromJson(Map<String, dynamic> json) => _$DeckFromJson(json);
  Map<String, dynamic> toJson() => _$DeckToJson(this);
}

@JsonSerializable()
class Capability {
  late Deck deck;

  Capability(this.deck);

  factory Capability.fromJson(Map<String, dynamic> json) =>
      _$CapabilityFromJson(json);
  Map<String, dynamic> toJson() => _$CapabilityToJson(this);
}

@JsonSerializable()
class CapabilitiesData {
  late Version version;
  late dynamic capabilities;

  CapabilitiesData(this.version, this.capabilities);

  factory CapabilitiesData.fromJson(Map<String, dynamic> json) =>
      _$CapabilitiesDataFromJson(json);
  Map<String, dynamic> toJson() => _$CapabilitiesDataToJson(this);
}

@JsonSerializable()
class AppPasswordData {
  late String apppassword;

  AppPasswordData(
    this.apppassword,
  );

  factory AppPasswordData.fromJson(Map<String, dynamic> json) =>
      _$AppPasswordDataFromJson(json);
  Map<String, dynamic> toJson() => _$AppPasswordDataToJson(this);
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

abstract class AuthService {
  Future<bool> login(
      String serverUrl, String username, String password, String? version);

  logout();

  Future<Capabilities> checkServer(String serverUrl);

  bool isAuth();

  Account? getAccount();
}
