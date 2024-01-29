import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServiceImpl extends GetxService implements IStorageService {
  final String keyUser = 'user';
  late final GetStorage _box;

  Future<IStorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    if (!_box.hasData(keyUser)) {
      _box.write(keyUser, {});
    }
    return this;
  }

  @override
  bool hasAccount() {
    return _box.hasData(keyUser);
  }

  @override
  Future<Account>? getAccount() async {
    return Account.fromJson(_box.read(keyUser));
  }

  @override
  saveAccount(Account a) async {
    await _box.write(keyUser, a.toJson());
  }
}
