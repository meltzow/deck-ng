import 'dart:convert';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:get/get.dart';

class AuthServiceImpl extends GetxService implements IAuthService {
  final httpService = Get.find<IHttpService>();
  final credService = Get.find<IStorageService>();

  final url = '/ocs/v2.php/core/getapppassword';

  String computeAuth(username, password) {
    return 'Basic ${base64.encode(utf8.encode('$username:$password'))}';
  }

  @override
  Future<bool> login(String serverUrl, String username, String password) async {
    //just save it, so the framework can use... but not authenticated (=false)
    var a = Account(
        username: username,
        password: password,
        authData: computeAuth(username, password),
        url: serverUrl.endsWith('/')
            ? serverUrl.substring(0, serverUrl.length - 1)
            : serverUrl,
        isAuthenticated: false);
    await credService.saveAccount(a);
    var resp = await httpService.get(serverUrl + url);
    var apppassword = AppPassword.fromJson(resp);
    a.password = apppassword.ocs.data.apppassword;
    a.isAuthenticated = true;
    await credService.saveAccount(a);

    return true;
  }
}
