import 'package:deck_ng/model/account.dart';

abstract class IAuthService {
  Future<Account> getAccount();

  saveCredentials(String url, String username, String password, bool isAuth);
}
