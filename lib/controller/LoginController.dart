import 'package:deck_ng/service/Iauth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxString nameControllerText = ''.obs;
  var nameController = TextEditingController();
  RxString passwordControllerText = ''.obs;
  var passwordController = TextEditingController();
  RxString urlControllerText = ''.obs;
  var urlController = TextEditingController();

  @override
  void onInit() {
    urlController.addListener(() {
      urlControllerText.value = urlController.text;
    });

    // debounce(urlControllerText, (_) {
    //   print("debouce$_");
    // }, time: const Duration(seconds: 1));

    nameController.addListener(() {
      nameControllerText.value = nameController.text;
    });

    // debounce(nameControllerText, (_) {
    //   print("debouce$_");
    // }, time: Duration(seconds: 1));

    passwordController.addListener(() {
      passwordControllerText.value = passwordController.text;
    });

    // debounce(passwordControllerText, (_) {
    //   print("debouce$_");
    // }, time: Duration(seconds: 1));

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await readAccountData();
  }

  readAccountData() async {
    var authService = Get.find<IAuthService>();
    var account = await authService.getAccount();

    urlControllerText.value = account.url;
    urlController.text = urlControllerText.value;
    nameControllerText.value = account.username;
    nameController.text = nameControllerText.value;
    passwordControllerText.value = account.password;
    passwordController.text = passwordControllerText.value;
  }

  login() async {
    var authService = Get.find<IAuthService>();
    authService.saveCredentials(urlControllerText.value,
        nameControllerText.value, passwordControllerText.value, true);
    Get.toNamed('/boards');
  }
}
