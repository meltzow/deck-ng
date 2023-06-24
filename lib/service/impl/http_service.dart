import 'dart:io';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;

class HttpService extends getx.GetxService implements IHttpService {
  final authRepo = getx.Get.find<IAuthService>();
  final Dio httpClient = getx.Get.find<Dio>();

  HttpService();

  Map<String, String> getHeaders(String path, Account account, [Object? body]) {
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: account.authData,
      HttpHeaders.acceptHeader: "application/json"
    };

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
  Future<Map<String, dynamic>> post(String path, Object? body) async {
    dynamic response;
    try {
      Account? account = await authRepo.getAccount();
      Response resp = await httpClient.post(account.url + path,
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
}
