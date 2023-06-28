import 'dart:convert';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthRepositoryImpl extends GetxService implements IAuthService {
  final String keyUser = 'user';
  late final GetStorage _box;
  final httpService = Get.find<IHttpService>();

  Future<IAuthService> init() async {
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

  @override
  Future<bool> login(String fullUrl) async {
    var resp = await httpService.post(fullUrl, false);
    var loginPollInfo = LoginPollInfo.fromJson(resp);
    // _launchInBrowser(Uri.parse(loginPollInfo.poll.endpoint));

    var ops = RequestOptions(
        path: loginPollInfo.poll.endpoint,
        queryParameters: {'token': loginPollInfo.poll.token},
        method: 'post');

    var response = await httpService
        .retry<LoginCredentials>(
            path: ops.path,
            queryParameters: ops.queryParameters,
            method: ops.method)
        .catchError((err) => false);

    await saveCredentials(response.data!.server, response.data!.loginName,
        response.data!.appPassword, true);

    return true;
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
