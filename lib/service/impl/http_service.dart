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

  Map<String, String> getHeaders(String path, Account account) {
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: account.authData,
      HttpHeaders.acceptHeader: "application/json"
    };

    if (path.startsWith('/ocs') || path.startsWith('/index.php/login/v2')) {
      headers['OCS-APIREQUEST'] = "true";
    }

    // headers['Content-Type'] = 'application/json';

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
  Future<Map<String, dynamic>> getResponse(String path) async {
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
