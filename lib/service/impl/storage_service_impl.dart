import 'dart:ui';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/model/setting.dart';
import 'package:deck_ng/service/services.dart';
import 'package:deck_ng/service/storage_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServiceImpl extends GetxService implements StorageService {
  final String keyUser = 'user';
  final String keySetting = 'setting';
  late GetStorage _box;

  @override
  void onInit() {
    super.onInit();

    _box = GetStorage();
    if (hasSettings()) {
      if (getSetting() != null && getSetting()!.language.isNotEmpty) {
        Get.updateLocale(Locale(getSetting()!.language));
      }
    }
  }

  @override
  bool hasAccount() {
    return _box.hasData(keyUser);
  }

  @override
  Account? getAccount() {
    return hasAccount() ? Account.fromJson(_box.read(keyUser)) : null;
  }

  @override
  saveAccount(Account? a) async {
    if (a == null) {
      return;
    }
    await _box.write(keyUser, a.toJson());
  }

  @override
  bool hasSettings() {
    return _box.hasData(keySetting);
  }

  @override
  Setting? getSetting() {
    return hasSettings() ? Setting.fromJson(_box.read(keySetting)) : null;
  }

  @override
  Future<void> saveSetting(Setting setting) async {
    await _box.write(keySetting, setting.toJson());
  }
}
