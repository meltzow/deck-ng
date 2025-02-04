import 'package:deck_ng/login/login_controller.dart';
import 'package:deck_ng/service/impl/notification_service_impl.dart';
import 'package:deck_ng/service/services.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationService>(() => NotificationServiceImpl());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
