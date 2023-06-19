import 'dart:convert';
import 'dart:io';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/model/board.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;

class HttpService extends getx.GetxService implements IHttpService {
  final String nextcloudBaseUrl = "http://192.168.178.59:8080";

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
  Future<Map<String, dynamic>> getResponse(String path) async {
    Map<String, dynamic> response;
    try {
      Account? account = await authRepo.getAccount();
      Response resp = await httpClient.get(nextcloudBaseUrl + path,
          options: Options(headers: getHeaders(path, account)));
      response = returnResponse(resp);
      // responseJson = returnResponse(response);
    } catch (error) {
      throw Exception(error.toString());
    }
    return response;
  }

  @visibleForTesting
  Map<String, dynamic> returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.data);
        return responseJson;
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
  Future<List<Board>> getAllBoards() {
    // TODO: implement getAllBoards
    throw UnimplementedError();
  }
}
