import 'dart:convert';
import 'dart:io';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/auth_service.dart';
import 'package:deck_ng/service/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthServiceImpl extends GetxService implements AuthService {
  final Dio dioClient = Get.find<Dio>();
  final storageService = Get.find<StorageService>();

  String _computeAuth(username, password) {
    return 'Basic ${base64.encode(utf8.encode('$username:$password'))}';
  }

  Map<String, String> _getHeaders(String path,
      [Account? account, Object? body]) {
    var headers = <String, String>{
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.userAgentHeader: 'deckNG client',
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
        username: username,
        password: password,
        authData: _computeAuth(username, password),
        url: serverUrl.endsWith('/')
            ? serverUrl.substring(0, serverUrl.length - 1)
            : serverUrl,
        isAuthenticated: false);
    await storageService.saveAccount(a);
    const firstTestUrl =
        '/ocs/v2.php/core/autocomplete/get?search=JOANNE%40EMAIL.ISP&itemType=%20&itemId=%20&shareTypes[]=8&limit=2';

    var resp = await dioClient.get(a.url + firstTestUrl,
        options: Options(headers: _getHeaders(firstTestUrl, a)));
    if (resp.statusCode == 200) {
      a.isAuthenticated = true;
      await storageService.saveAccount(a);
      try {
        //test if creating a app password is possible
        const url = '/ocs/v2.php/core/getapppassword';
        var resp = await dioClient.get(a.url + url,
            options: Options(headers: _getHeaders(url, a)));
        var apppassword = AppPassword.fromJson(resp.data);
        a.password = apppassword.ocs.data.apppassword;
        a.authData = _computeAuth(a.username, a.password);
        await storageService.saveAccount(a);
      } catch (e) {
        //this is expected if user inserted a app password (app password must not create new app passwords)
        print(e);
      }
      return true;
    }

    return false;
  }

  @override
  Future<Capabilities> checkServer(String serverUrl) async {
    var url = '/ocs/v2.php/cloud/capabilities';

    var resp = await dioClient.get(serverUrl + url,
        options: Options(headers: _getHeaders(url)));

    return Capabilities.fromJson(resp.data);
  }

  @override
  bool isAuth() {
    var auth = storageService.getAccount();
    return auth != null && auth.isAuthenticated;
  }

  @override
  Account? getAccount() {
    return storageService.getAccount();
  }

  @override
  logout() {
    if (storageService.hasAccount()) {
      var acc = storageService.getAccount()!;
      acc.isAuthenticated = false;
      acc.password = '';
      acc.authData = '';
      storageService.saveAccount(acc);
    }
  }
}
