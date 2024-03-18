import 'dart:convert';

import 'package:deck_ng/model/account.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Icard_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/Inotification_service.dart';
import 'package:deck_ng/service/Istack_service.dart';
import 'package:deck_ng/service/Istorage_service.dart';
import 'package:deck_ng/service/impl/auth_service_impl.dart';
import 'package:deck_ng/service/impl/board_service_impl.dart';
import 'package:deck_ng/service/impl/card_service_impl.dart';
import 'package:deck_ng/service/impl/http_service.dart';
import 'package:deck_ng/service/impl/notification_service_impl.dart';
import 'package:deck_ng/service/impl/stack_repository_impl.dart';
import 'package:deck_ng/service/impl/storage_service_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class Environment {
  static Future<void> init() async {
    await _initServices();
  }

  static Future<void> _initServices() async {
    await Get.putAsync<IStorageService>(() => StorageServiceImpl().init());

    if (kDebugMode) {
      IStorageService service = Get.find<IStorageService>();
      if (!service.hasAccount()) {
        var a = Account(
            "admin",
            "admin",
            'Basic ${base64.encode(utf8.encode('admin:admin'))}',
            "http://192.168.178.81:8080",
            false);
        //FIXME
        //        await service.saveAccount(a);
      }
    }
    // await Get.putAsync<IStorageService>(() => StorageServiceImpl().init());
    Get.lazyPut<Dio>(() => Dio());
    Get.lazyPut<IAuthService>(() => AuthServiceImpl());
    Get.lazyPut<IHttpService>(() => HttpService());
    Get.lazyPut<IBoardService>(() => BoardServiceImpl());
    Get.lazyPut<IStackService>(() => StackRepositoryImpl());
    Get.lazyPut<ICardService>(() => CardServiceImpl());
    Get.lazyPut<INotificationService>(() => NotificationService());
  }
}
