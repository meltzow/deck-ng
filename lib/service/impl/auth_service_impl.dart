import 'dart:convert';
import 'dart:io';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthServiceImpl extends GetxService implements IAuthService {
  final Dio dioClient = Get.find<Dio>();
  final credService = Get.find<IStorageService>();

  final url = '/ocs/v2.php/core/getapppassword';

  String computeAuth(username, password) {
    return 'Basic ${base64.encode(utf8.encode('$username:$password'))}';
  }

  Map<String, String> _getHeaders(String path,
      [Account? account, Object? body]) {
    var headers = <String, String>{
      HttpHeaders.acceptHeader: "application/json"
    };
    if (account?.authData != null) {
      headers[HttpHeaders.authorizationHeader] = account!.authData;
    }

    if (path.contains('/ocs') || path.contains('/index.php/login/v2')) {
      headers['OCS-APIREQUEST'] = "true";
    }

    if (body != null) {
      headers['Content-Type'] = 'application/json';
    }

    return headers;
  }

  @override
  Future<bool> login(String serverUrl, String username, String password) async {
    //just save it, so the framework can use... but not authenticated (=false)
    var a = Account(
        username,
        password,
        computeAuth(username, password),
        serverUrl.endsWith('/')
            ? serverUrl.substring(0, serverUrl.length - 1)
            : serverUrl,
        false);
    await credService.saveAccount(a);

    var resp = await dioClient.get(serverUrl + url,
        options: Options(headers: _getHeaders(url, a)));
    var apppassword = AppPassword.fromJson(resp.data);
    a.password = apppassword.ocs.data.apppassword;
    a.isAuthenticated = true;
    await credService.saveAccount(a);

    return true;
  }

  @override
  bool isAuth() {
    var auth = credService.getAccount();
    return auth != null && auth.isAuthenticated;
  }

  @override
  Account? getAccount() {
    return credService.getAccount();
  }
}
