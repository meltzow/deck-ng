import 'dart:io';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/impl/retry.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;

class HttpService extends getx.GetxService implements IHttpService {
  final credService = getx.Get.find<ICredentialService>();
  final Dio httpClient = getx.Get.find<Dio>();

  HttpService();

  Map<String, String> getHeaders(String path,
      [Account? account, Object? body]) {
    var headers = <String, String>{
      HttpHeaders.acceptHeader: "application/json"
    };
    if (account?.authData != null) {
      headers[HttpHeaders.authorizationHeader] = account!.authData;
    }

    if (path.startsWith('/ocs') || path.startsWith('/index.php/login/v2')) {
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
    Account? account = await credService.getAccount();
    try {
      Response resp = await httpClient.get((account!=null?account.url:'') + path,
          options: Options(headers: getHeaders(path, account)));
      response = (returnResponse(resp) as List<dynamic>);
    } catch (error) {
      throw Exception(error.toString());
    }
    return response;
  }

  @override
  Future<Map<String, dynamic>> get(String path) async {
    dynamic response;
    try {
      Account? account = await credService.getAccount();
      Response resp = await httpClient.get((account!=null?account.url:'') + path,
          options: Options(headers: getHeaders(path, account)));
      response = returnResponse(resp);
    } catch (error) {
      throw Exception(error.toString());
    }
    return response;
  }

  @override
  Future<Map<String, dynamic>> post(String path,
      [dynamic body, bool useAccount = true]) async {
    dynamic response;
    try {
      Account? account = useAccount ? await credService.getAccount() : null;
      var url = account != null ? account.url : '';
      Response resp = await httpClient.post(url + path,
          options: Options(headers: getHeaders(path, account, body)),
          data: body);
      response = returnResponse(resp);
    } catch (error) {
      throw Exception(error.toString());
    }
    return response;
  }

  @override
  Future<Map<String, dynamic>> put(String path, Object? body) async {
    dynamic response;
    try {
      Account? account = await credService.getAccount();
      var headers = getHeaders(path, account, body);
      Response resp = await httpClient.put((account!=null?account.url:'') + path,
          options: Options(headers: headers), data: body);
      response = returnResponse(resp);
    } catch (error) {
      throw Exception(error.toString());
    }
    return response;
  }

  @visibleForTesting
  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw Exception(response.data.toString());
      case 401:
      case 403:
        throw Exception(response.data.toString());
      case 500:
      default:
        throw Exception('Error occurred while communication with server' +
            ' with status code : ${response.statusCode}');
    }
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
}
