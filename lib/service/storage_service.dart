import 'package:deck_ng/model/models.dart';

abstract class StorageService {
  Account? getAccount();
  bool hasAccount();

  saveAccount(Account? account);

  bool hasSettings();
  Setting? getSetting();
  saveSetting(Setting setting);
}
