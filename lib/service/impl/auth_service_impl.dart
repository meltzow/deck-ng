import 'dart:io';

import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthServiceImpl extends GetxService implements IAuthService {
  final Dio httpClient = Get.find<Dio>();
  final credService = Get.find<ICredentialService>();

  final url = '/ocs/v2.php/core/getapppassword';

  @override
  Future<bool> login(String serverUrl, String username, String password) async {
    var headers = <String, String>{
      HttpHeaders.acceptHeader: "application/json",
      'OCS-APIREQUEST': "true",
      HttpHeaders.authorizationHeader: account!.authData;
    };

    var resp = await httpClient.get(serverUrl + url,options: Options(headers: headers));
    if (resp.statusCode == 200 ) {
      var response = resp.data as Map<String, dynamic>;
      var apppassword = AppPassword.fromJson(response);
      await credService.saveCredentials(serverUrl,
          username, apppassword.ocs.data.apppassword, true);

    }

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
