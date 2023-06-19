import 'package:deck_ng/controller/controller.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/auth_repository_impl.dart';
import 'package:deck_ng/service/board_repository_impl.dart';
import 'package:deck_ng/service/http_service.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepositoryImpl>(() => AuthRepositoryImpl());
    Get.lazyPut<BoardRepositoryImpl>(() => BoardRepositoryImpl());
    Get.lazyPut<IHttpService>(() => HttpService());

    Get.put<Controller>(Controller());
  }
}
