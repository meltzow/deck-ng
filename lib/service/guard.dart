import 'package:deck_ng/app_routes.dart';
import 'package:deck_ng/service/Istorage_service.dart';
import 'package:deck_ng/service/impl/storage_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Guard extends GetMiddleware {
  final storageService = Get.put<IStorageService>(StorageServiceImpl());

  @override
  RouteSettings? redirect(String? route) {
    return (storageService.hasAccount() &&
            storageService.getAccount()!.isAuthenticated)
        ? null
        : const RouteSettings(name: AppRoutes.login);
  }
}
