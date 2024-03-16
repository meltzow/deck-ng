import 'package:deck_ng/service/Iauth_service.dart';
import 'package:get/get.dart';

class DrawerController extends GetxController {
  var authService = Get.find<IAuthService>();

  RxBool get isAuth => authService.isAuth().obs;

  void logout() {
    authService.logout();
  }
}
