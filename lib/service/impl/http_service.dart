import 'dart:io';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;

class HttpService extends getx.GetxService implements IHttpService {
  final authRepo = getx.Get.find<IAuthService>();
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
    Account? account = await authRepo.getAccount();
    try {
      Response resp = await httpClient.get(account.url + path,
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
      Account? account = await authRepo.getAccount();
      Response resp = await httpClient.get(account.url + path,
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
      Account? account = useAccount ? await authRepo.getAccount() : null;
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
      Account? account = await authRepo.getAccount();
      var headers = getHeaders(path, account, body);
      Response resp = await httpClient.put(account.url + path,
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
  Future<Response<T>> retry<T>(
      {required String path,
      required String method,
      Map<String, dynamic>? queryParameters}) async {
    final evaluator = DefaultRetryEvaluator({status400BadRequest});
    httpClient.interceptors.add(
      RetryInterceptor(
          // ignoreRetryEvaluatorExceptions: true,
          dio: httpClient,
          logPrint: print, // specify log function (optional)
          retries: 4, // retry count (optional)
          retryDelays: const [
            // set delays between retries (optional)
            Duration(seconds: 1), // wait 1 sec before the first retry
            Duration(seconds: 2), // wait 2 sec before the second retry
            Duration(seconds: 3), // wait 3 sec before the third retry
            Duration(seconds: 4), // wait 4 sec before the fourth retry
          ],
          retryEvaluator: evaluator.evaluate),
    );

    var ops = RequestOptions(path: path, method: method);

    return await httpClient.fetch<T>(ops);
  }
}
