import 'package:deck_ng/service/Iauth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Guard extends GetMiddleware {
  final authService = Get.find<IAuthService>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.isAuth()
        ? null
        : const RouteSettings(name: '/auth/login');
  }
}