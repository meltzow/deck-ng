import 'package:deck_ng/controller/controller.dart';
import 'package:deck_ng/service/Iauth_service.dart';
import 'package:deck_ng/service/Ihttp_service.dart';
import 'package:deck_ng/service/auth_repository_impl.dart';
import 'package:deck_ng/service/board_repository_impl.dart';
import 'package:deck_ng/service/http_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:test/test.dart';

void main() {
  test(
      '''Test the state of the reactive variable "name" across all of its lifecycles''',
      () {
    Get.put<IAuthService>(AuthRepositoryImpl());
    Get.put<Dio>(Dio());
    Get.put<IHttpService>(HttpService());
    Get.put<BoardRepositoryImpl>(BoardRepositoryImpl());

    final controller = Get.put(Controller());
    expect(controller.count.value, 0);

    /// If you are using it, you can test everything,
    /// including the state of the application after each lifecycle.
    Get.put(controller); // onInit was called
    expect(controller.count.value, 0);

    /// Test your functions
    controller.increment();
    expect(controller.count.value, 1);

    /// onClose was called
    Get.delete<Controller>();

    expect(controller.count.value, 1);
  });
}
