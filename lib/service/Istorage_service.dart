import 'package:deck_ng/model/models.dart';

abstract class IStorageService {
  Account? getAccount();
  bool hasAccount();

  saveAccount(Account account);

  bool hasSettings();
  Setting? getSetting();
  saveSetting(Setting setting);
}
