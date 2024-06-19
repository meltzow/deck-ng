import 'dart:io';

import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/auth_service.dart';
import 'package:deck_ng/service/http_service.dart';
import 'package:deck_ng/service/impl/retry.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getX;

class HttpServiceImpl extends getX.GetxService implements HttpService {
  final AuthService authService = getX.Get.find<AuthService>();
  final Dio httpClient = getX.Get.find<Dio>();

  HttpServiceImpl();

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
    Account? account = useAccount ? authService.getAccount() : null;
    var url = account != null ? account.url : '';
    Response resp = await httpClient.post(url + path,
        options: Options(headers: getHeaders(path, account, body)), data: body);
    response = resp.data;
    return response;
  }

  @override
  Future<T> put<T>(String path, Object? body) async {
    Account? account = authService.getAccount();
    var headers = getHeaders(path, account, body);
    Response resp = await httpClient.put<T>(
        (account != null ? account.url : '') + path,
        options: Options(headers: headers),
        data: body);
    return resp.data;
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
      print("onError: ${err.message}");
    }
    getX.Get.toNamed(AppRoutes.login);
    return handler.next(err);
  }
}
