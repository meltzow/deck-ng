import 'package:deck_ng/controller/board_overview_controller.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Iboard_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/auth_repository_impl.dart';
import 'package:deck_ng/service/board_repository_impl.dart';
import 'package:deck_ng/service/http_service.dart';
import 'package:deck_ng/service/stack_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<IAuthService>(() => AuthRepositoryImpl());
    Get.lazyPut<IBoardService>(() => BoardRepositoryImpl());
    Get.lazyPut<StackRepositoryImpl>(() => StackRepositoryImpl());
    Get.lazyPut<Dio>(() => Dio());
    Get.lazyPut<IHttpService>(() => HttpService());

    Get.put<BoardOverviewController>(BoardOverviewController());
  }
}
