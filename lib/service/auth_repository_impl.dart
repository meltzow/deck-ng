import 'dart:convert';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthRepositoryImpl extends GetxService implements IAuthService {
  final String keyUser = 'user';
  final _box = GetStorage();

  AuthRepositoryImpl() {
    GetStorage.init();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

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
