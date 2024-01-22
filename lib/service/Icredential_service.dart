import 'package:deck_ng/model/account.dart';

abstract class ICredentialService {
  Future<Account> getAccount();
  bool hasAccount();

  saveCredentials(String url, String username, String password, bool isAuth);
}
