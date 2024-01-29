import 'package:deck_ng/model/account.dart';

abstract class IStorageService {
  Future<Account>? getAccount();
  bool hasAccount();

  saveAccount(Account account);
}
