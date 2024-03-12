import 'dart:async';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Istorage_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServiceImpl extends GetxService implements IStorageService {
  final String keyUser = 'user';
  late final GetStorage _box;

  Future<IStorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
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
  saveAccount(Account a) async {
    await _box.write(keyUser, a.toJson());
  }
}
