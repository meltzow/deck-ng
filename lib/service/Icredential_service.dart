import 'dart:async';

import 'package:deck_ng/model/account.dart';

abstract class IStorageService {
  Account? getAccount();
  bool hasAccount();

  saveAccount(Account account);
}
