import 'package:deck_ng/model/account.dart';

abstract class ICredentialService {
  Future<Account> getAccount();

  saveCredentials(String url, String username, String password, bool isAuth);
}
