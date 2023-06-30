import 'dart:convert';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CredentialServiceImpl extends GetxService implements ICredentialService {
  final String keyUser = 'user';
  late final GetStorage _box;

  Future<ICredentialService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    //FIXME remove fixed data
    saveCredentials("http://192.168.178.59:8080", "admin", "admin", true);
    return this;
  }

  @override
  Future<Account> getAccount() async {
    return Account.fromJson(_box.read(keyUser)!);
  }

  @override
  saveCredentials(
      String url, String username, String password, bool isAuth) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    url = url.endsWith('/') ? url.substring(1) : url;
    var a = Account(
        username: username,
        password: password,
        authData: basicAuth,
        url: url,
        isAuthenticated: isAuth);
    await _box.write(keyUser, a.toJson());
  }
}
