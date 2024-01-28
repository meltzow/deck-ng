import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Icredential_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthServiceImpl extends GetxService implements IAuthService {
  final httpService = Get.find<IHttpService>();
  final credService = Get.find<ICredentialService>();

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
        .retry<LoginCredentials>(ops, null)
        .catchError((err) => false);

    await credService.saveCredentials(response.data!.server,
        response.data!.loginName, response.data!.appPassword, true);

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
