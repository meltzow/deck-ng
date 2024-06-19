import 'package:deck_ng/service/auth_service.dart';
import 'package:get/get.dart';

class DrawerController extends GetxController {
  var authService = Get.find<AuthService>();

  RxBool get isAuth => authService.isAuth().obs;

  void logout() {
    authService.logout();
  }
}
