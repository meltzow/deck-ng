import 'dart:io';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/impl/retry.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getX;

class HttpService extends getX.GetxService implements IHttpService {
  final IAuthService authService = getX.Get.find<IAuthService>();
  final Dio httpClient = getX.Get.find<Dio>();

  HttpService();

  Map<String, String> getHeaders(String path,
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
  Future<List<dynamic>> getListResponse(String path) async {
    List<dynamic> response;
    Account? account = authService.getAccount();
    Response resp = await httpClient.get(
        (authService.isAuth() ? account!.url : '') + path,
        options: Options(headers: getHeaders(path, account)));
    response = (resp.data as List<dynamic>);
    return response;
  }

  @override
  Future<Map<String, dynamic>> get(String path) async {
    dynamic response;
    Account? account = authService.getAccount();
    Response resp = await httpClient.get(
        (authService.isAuth() ? account!.url : '') + path,
        options: Options(headers: getHeaders(path, account)));
    response = resp.data;
    return response;
  }

  @override
  Future<Map<String, dynamic>> post(String path,
      [dynamic body, bool useAccount = true]) async {
    dynamic response;
    Account? account = useAccount ? await authService.getAccount() : null;
    var url = account != null ? account.url : '';
    Response resp = await httpClient.post(url + path,
        options: Options(headers: getHeaders(path, account, body)), data: body);
    response = resp.data;
    return response;
  }

  @override
  Future<Map<String, dynamic>> put(String path, Object? body) async {
    dynamic response;
    Account? account = authService.getAccount();
    var headers = getHeaders(path, account, body);
    Response resp = await httpClient.put(
        (account != null ? account.url : '') + path,
        options: Options(headers: headers),
        data: body);
    response = resp.data;
    return response;
  }

  @override
  Future<Response<T>> retry<T>(RequestOptions? ops,
      [RetryOptions? retryOptions]) async {
    var retryOps = retryOptions ??
        const RetryOptions(
            delayFactor: Duration(seconds: 2),
            maxDelay: Duration(minutes: 2),
            maxAttempts: 200);
    return retryOps.retry<Response<T>>(
        () async => await httpClient.fetch<T>(ops!),
        retryIf: (e) => e is DioException,
        onRetry: (e) {
          ops!.headers[RetryOptions.retryHeader] =
              ops.headers[RetryOptions.retryHeader] != null
                  ? ops.headers[RetryOptions.retryHeader] + 1
                  : 1;
        });
  }

  @override
  void onInit() {
    super.onInit();

    httpClient.interceptors.add(CustomInterceptor());
  }
}

class CustomInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      print("onError: ${err.response?.statusCode}");
    }
    getX.Get.toNamed('/auth/login');
    return handler.next(err);
  }
}
